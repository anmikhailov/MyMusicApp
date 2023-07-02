//
//  FavoritesViewPresenter.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import Foundation

class FavoritesViewPresenter: FavoritesViewOutput {
    
    weak var view: FavoritesViewInput!
    var favoritesManager: FavoritesManager!
    
    func requestDataForTableView() {
        let favoritesItems = favoritesManager.obtainFavorites()
        
        view.fillDataForTableView(with: favoritesItems)
    }
    
    
}
