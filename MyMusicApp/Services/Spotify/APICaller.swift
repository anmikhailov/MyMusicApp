//
//  APICaller.swift
//  MyMusicApp
//
//  Created by Andrey on 17.06.2023.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://api.spotify.com/v1"
    }
    
    // MARK: - Recently played tracks
//    public func getFiveRecentlyPlayedTracks(completion: @escaping (Result<RecentlyTracks, Error>) -> Void) {
//        createRequest(with: URL(string: Constants.baseAPIURL + "/me/player/recently-played?limit=5"),
//                      type: .GET) { baseRequest in
//            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.failedToGetData))
//                    return
//                }
//
//                do {
//                    let result = try JSONDecoder().decode(RecentlyTracks.self, from: data)
//
//                    print(result)
//                    completion(.success(result))
//
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//
//            task.resume()
//        }
//    }
    
    // MARK: - New releases
//    public func getNewReleasesAlbums(completion: @escaping (Result<AlbumsResponse, Error>) -> Void) {
//        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases"), type: .GET) { baseRequest in
//            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.failedToGetData))
//                    return
//                }
//
//                do {
//                    let result = try JSONDecoder().decode(AlbumsResponse.self, from: data)
//
//                    print(result)
//                    completion(.success(result))
//
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//
//            task.resume()
//        }
//    }
    
    //MARK: - User Profile Information
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(result)
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    public func search(with query: String, completion: @escaping (Result<[SearchResult], Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?limit=5&type=album,track,playlist,artist&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"),
                      type: .GET) { request in
            print(request.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchResultResponse.self, from: data)
                    
                    var searchResults: [SearchResult] = []
                    searchResults.append(contentsOf: result.tracks.items.compactMap({ .track(model: $0) }))
                    searchResults.append(contentsOf: result.albums.items.compactMap({ .album(model: $0) }))
                    searchResults.append(contentsOf: result.artists.items.compactMap({ .artist(model: $0) }))
                    searchResults.append(contentsOf: result.playlists.items.compactMap({ .playlist(model: $0) }))
                    
                    completion(.success(searchResults))
                } catch {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    //MARK - Private func
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            
            completion(request)
        }
        
    }
}
