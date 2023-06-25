//
//  FirebaseManager.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import GoogleSignIn

final class FirebaseManager {
    static let shared = FirebaseManager()
    
    var userDefaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var userUid: String {
        get {
            if let uid = userDefaults.string(forKey: "UserUID") {
                return uid
            } else {
                return ""
            }
        }
        set {
            userDefaults.set(newValue, forKey: "UserUID")
        }
    }
    
    // MARK: - Create account
    func createAccount(email: String,
                       password: String,
                       username: String,
                       completion: @escaping (Error?) -> ()
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error == nil {
                if let result = result {
                    self?.userUid = result.user.uid
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["name" : username])
                    ref.child(result.user.uid).updateChildValues(["email" : email])
                    
                    self?.saveInUserDefaults(userInfo: UserInfo(name: username, email: email))
                    completion(nil)
                }
            } else {
                completion(error)
            }
        }
    }
    
    // MARK: - Change profile info
    func changeProfileInfo(email: String, name: String, completion: @escaping (Error?) -> ()) {
        if !userUid.isEmpty {
            let ref = Database.database().reference().child("users")
            ref.child(userUid).updateChildValues(["name" : name])
            ref.child(userUid).updateChildValues(["email" : email])
            
            self.saveInUserDefaults(userInfo: UserInfo(name: name, email: email))
        }
        
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error == nil {
                if let result = result {
                    self?.userUid = result.user.uid
                    self?.fetchUserInfo(for: result.user.uid, complition: { info, error in
                        if error == nil {
                            self?.saveInUserDefaults(userInfo: info)
                            completion(nil)
                        } else {
                            completion(error)
                        }
                    })
                }
            } else {
                completion(error)
            }
        }
    }
    
    // MARK: - Google auth
    func googleAuth(withPresenting: UIViewController, completion: @escaping (Error?) -> ()) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: withPresenting) { result, error in
            guard error == nil else { completion(error); return }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else { completion(error); return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [weak self] result, err in
                if err == nil {
                    if let result = result {
                        self?.userUid = result.user.uid
                        let info = UserInfo(name: result.user.displayName, email: result.user.email)
                        self?.saveInUserDefaults(userInfo: info)
                        completion(nil)
                    }
                } else {
                    completion(err)
                }
            }
        }
    }
    
    // MARK: - reset and change password
    func resetPassword(email: String,
                       completion: @escaping (Error?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) {error in
            completion(error)
        }
    }
    
    func changePassword(password: String,
                        completion: @escaping (Error?) -> ()) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            completion(error)
        }
    }
    
    // MARK: - Sign out
    func signOut(completion: @escaping () -> ()) {
        do {
            try Auth.auth().signOut()
            completion()
        } catch {

        }
    }
    
    // MARK: - get user info from UserDefaults
    func getFromUserDefaultsUserInfo() -> UserInfo? {
        guard let info = userDefaults.object(forKey: "userInfo") as? Data else {
            return nil
        }
        guard let decodedInfo = try? decoder.decode(UserInfo.self, from: info) else {
            return nil
        }

        return decodedInfo
    }
    
    // MARK: - fetch user info
    private func fetchUserInfo(for userId: String, complition: @escaping (UserInfo, Error?) -> ()) {
        var userInfo = UserInfo()

        let data = Database.database().reference(withPath: "users")
        data.child(userId).child("name").getData { error, data in
            if error == nil {
                if let data = data {
                    let name = data.value as? String
                    userInfo.name = name
                }
            } else {
                complition(userInfo, error)
            }
        }
        data.child(userId).child("email").getData { error, data in
            if error == nil {
                if let data = data {
                    let email = data.value as? String
                    userInfo.email = email
                    complition(userInfo, nil)
                }
            } else {
                complition(userInfo, error)
            }
        }
    }
    
    // MARK: - Save UserDefaults
    private func saveInUserDefaults(userInfo: UserInfo) {
        guard let encoded = try? encoder.encode(userInfo) else { return }
        userDefaults.set(encoded, forKey: "userInfo")
    }
}
