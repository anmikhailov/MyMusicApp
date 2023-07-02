//
//  FavoritesAssembly.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import Foundation
import UIKit

class FavoritesAssembly {
    
    class func configuredModule() -> UIViewController {
        let view = FavoritesViewController()
        let presenter = FavoritesViewPresenter()
        let dataManager = FavoritesManagerImplementation()
        
        view.output = presenter
        presenter.view = view
        presenter.favoritesManager = dataManager
        
        return view
    }
}
