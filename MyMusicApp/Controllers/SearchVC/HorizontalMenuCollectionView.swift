//
//  HorizontalMenuCollectionView.swift
//  MyMusicApp
//
//  Created by Andrey on 15.06.2023.
//

import Foundation
import UIKit

protocol SelectCollectionViewItemProtocol: AnyObject {
    func selectItem(index: IndexPath)
}

class HorizontalMenuCollectionView: UICollectionView {
    
    private let categoryLayout = UICollectionViewFlowLayout()
    let menuTitlesArray = ["All", "Artist", "Album", "Song", "Playlist"]
    
    weak var cellDelegate: SelectCollectionViewItemProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        categoryLayout.minimumInteritemSpacing = 20
        categoryLayout.scrollDirection = .horizontal
        
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        
        selectItem(at: [0,0], animated: true, scrollPosition: [])
        self.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

//MARK: - UICollectionViewDataSource
extension HorizontalMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTitlesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HorizontalCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = menuTitlesArray[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HorizontalMenuCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(index: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HorizontalMenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let menuFont = HorizontalCollectionViewCell.menuFont
        let menuAttributes = [NSAttributedString.Key.font: menuFont as Any]
        let menuCellWidth = menuTitlesArray[indexPath.item].size(withAttributes: menuAttributes).width + 20
        
        return CGSize(width: menuCellWidth, height: collectionView.frame.height)
    }
}
