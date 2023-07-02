//
//  FavoritesView.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import UIKit

class FavoritesView: UIView {
    
    lazy var favoritesTableView: UITableView = {
        let element = UITableView()
        element.backgroundColor = .backgroundColor
        element.register(MusicItemTableViewCell.self, forCellReuseIdentifier: "MusicItemTableViewCell")
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        addView(favoritesTableView)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
