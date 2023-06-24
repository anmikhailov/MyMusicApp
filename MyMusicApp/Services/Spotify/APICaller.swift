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
    public func getFiveRecentlyPlayedTracks(completion: @escaping (Result<RecentlyTracks, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/player/recently-played?limit=5"),
                      type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(RecentlyTracks.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - New releases
    public func getNewReleasesAlbums(country: String, limit: Int, completion: @escaping (Result<AlbumsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/browse/new-releases?country=SE&limit=10&offset=5"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(AlbumsResponse.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - User's recommendations (MAX LIMIT - 50)
    public func getUsersRecommendations(with id: String, limit: Int, completion: @escaping (Result<TopResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/top/tracks?limit=" + String(limit)), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(TopResponse.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - Get user's playlists (max: 50)
    public func getUsersPlaylists(limit: Int, completion: @escaping (Result<UsersPlaylistsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/me/top/playlists" + "?limit=" + String(limit)), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(UsersPlaylistsResponse.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - Get Album
    public func getAlbum(with id: String, completion: @escaping (Result<Album, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/albums/" + id), type: .GET) { baseRequest in
            print(baseRequest.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(Album.self, from: data)
//                    let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - Get Artist's tracks
    public func getArtistsTracks(with id: String, completion: @escaping (Result<ArtistsTracks, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/artists/" + id + "/top-tracks?market=ES"), type: .GET) { baseRequest in
            print(baseRequest.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(ArtistsTracks.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - Get Playlist's tracks
    public func getPlaylistTracks(with id: String, completion: @escaping (Result<PlaylistsTracks, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/playlists/" + id + "/tracks"), type: .GET) { baseRequest in
            print(baseRequest.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(PlaylistsTracks.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - Get genre tracks
    public func getGenreTracks(for genre: String, completion: @escaping (Result<RecommendedTrack, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations?seed_genres=" + genre), type: .GET) { baseRequest in
            print(baseRequest.url?.absoluteString ?? "none")
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(RecommendedTrack.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - Get track
    public func getTrack(with id: String, completion: @escaping (Result<SpotifyTrack, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/tracks/" + id), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(SpotifyTrack.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
    // MARK: - get genres
    public func getGenres(completion: @escaping (Result<Genres, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(Genres.self, from: data)
                    completion(.success(result))

                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        }
    }
    
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
                    completion(.success(result))
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
