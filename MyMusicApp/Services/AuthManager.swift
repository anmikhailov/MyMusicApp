//
//  AuthManager.swift
//  MyMusicApp
//
//  Created by Kovs on 12.06.2023.
//

import Foundation
import UIKit

final class AuthManager {
    
    static let shared = AuthManager()
    let standard = UserDefaults.standard
    
    private init() {}
    
    // MARK: - URL
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize?"
        let string = "\(base)response_type=code&client_id=\(Web.clientID)&scope=\(Web.scopes)&redirect_uri=\(Web.redirectURI)&show_dialog=TRUE"
        
        return URL(string: string)
    }
    
    // MARK: - Properties
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return standard.object(forKey: "expirationDate") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public func exchangeCodeForToken(code: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: Web.tokenApiURL) else { return }
        
        // components
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "redirect_uri", value: Web.redirectURI)
        ]
        
        // request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        // token
        let basicToken = Web.clientID + ":" + Web.secretID
        let data = basicToken.data(using: .utf8)
        
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        // task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    public func refreshIfNeeded(completion: @escaping (Bool) -> Void) {
       
        guard let refreshToken = self.refreshToken else {
            return
        }
        
        //Refresh token
        guard let url = URL(string: Web.tokenApiURL) else { return }
        
        // components
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type",
                         value: "refresh_token"),
            URLQueryItem(name: "refresh_token",
                         value: refreshToken),
        ]
        
        // request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded ", forHTTPHeaderField: "Content-Type")
        request.httpBody = components.query?.data(using: .utf8)
        
        // token
        let basicToken = Web.clientID + ":" + Web.secretID
        let data = basicToken.data(using: .utf8)
        
        guard let base64String = data?.base64EncodedString() else {
            print("Failure to get base64")
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        // task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let self = self else { return }
            
            guard let data = data, error == nil else {
                completion(false)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                print("Successfully refreshed")
                self.cacheToken(result: result)
                completion(true)
            } catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        task.resume()
    }
    
    private func cacheToken(result: AuthResponse) {
        standard.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = result.refresh_token {
            standard.setValue(result.refresh_token, forKey: "refresh_token")
        }
        standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
}


