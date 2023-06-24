//
//  PersistenceManager.swift
//  MyMusicApp
//
//  Created by Kovs on 20.06.2023.
//

import Foundation

protocol PersistenceManagerProtocol {
    func updateWith(favorite: Track, actionType: PersistenceActionType, completed: @escaping (FavoriteError?) -> Void)
    func retreiveTrack(completed: @escaping (Result<[Track], FavoriteError>) -> Void)
    func save(favorites: [Track]) -> FavoriteError?
}


enum PersistenceActionType { case add, remove }


class PersistenceManager: PersistenceManagerProtocol {
    private let defaults = UserDefaults.standard
    
    static let shared = PersistenceManager()
    
    // MARK: - Добавление или удаление избранного, принимает в функцию трек, выбирается случай, либо add либо remove
    func updateWith(favorite: Track, actionType: PersistenceActionType, completed: @escaping (FavoriteError?) -> Void) {
        retreiveTrack { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    
                    guard !favorites.contains(favorite) else {
                        // if contains:
                        completed(.alreadyFavorited)
                        return
                    }
                    
                    // if you didn't add this user yet:
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.id == favorite.id}
                }
                
                completed(self.save(favorites: favorites))
                
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
 // MARK: - Getting favorites [Track], or [], or fail
    func retreiveTrack(completed: @escaping (Result<[Track], FavoriteError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            // if nil = no favorites
            completed(.success([]))
            return
        }
        
        // decode into favorites array:
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Track].self, from: favoritesData)
            
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
        
    }
    
    func save(favorites: [Track]) -> FavoriteError? {
        // encode:
        do {
            let encoder = JSONEncoder()
            let encodedfavorites = try encoder.encode(favorites)
            
            // save to dafaults:
            defaults.set(encodedfavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
