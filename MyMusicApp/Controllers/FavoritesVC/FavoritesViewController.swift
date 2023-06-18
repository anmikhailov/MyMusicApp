//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    enum Constans {
        static let background = UIColor(named: "Background")
    }
    // MARK: - let/var
    let favoriteView = FavoriteView()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
    }
}
extension FavoritesViewController {
    // MARK: - setConstrains
    private func setupViews() {
        view.backgroundColor = Constans.background
        
        view.addSubview(favoriteView) 
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
