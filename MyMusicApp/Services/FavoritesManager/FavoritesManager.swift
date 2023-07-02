//
//  FavoritesManager.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import Foundation

protocol FavoritesManager {
    func obtainFavorites() -> [String]
}

class FavoritesManagerImplementation: FavoritesManager {
    func obtainFavorites() -> [String] {
        ["Track 1", "Track 2", "Track 3", "Track 4", "Track 5"]
    }
    
    
}
