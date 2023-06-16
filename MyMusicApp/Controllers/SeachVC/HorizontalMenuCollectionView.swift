//
//  HorizontalMenuCollectionView.swift
//  MyMusicApp
//
//  Created by Andrey on 15.06.2023.
//

import Foundation
import UIKit

class HorizontalMenuCollectionView: UICollectionView {
    
    private let categoryLayout = UICollectionViewLayout()
    let menuTitlesArray = ["All", "Artist", "Album", "Song", "Playlist"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        
        self.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

//MARK: - UICollectionViewDataSource
extension HorizontalMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("///")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HorizontalCollectionViewCell
        else {
            fatalError("Error")
        }
        print("Cell init complete \(cell)")
        cell.backgroundColor = .white
//        cell.titleLabel.text = menuTitlesArray[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HorizontalMenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalMenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
}
