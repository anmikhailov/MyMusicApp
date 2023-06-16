//
//  CollectionView.swift
//  MyMusicApp
//
//  Created by mac on 6/13/23.
//

import UIKit

class CustomeCollectionView: UIView {
    
    // MARK: - Properties

    var collectionView: UICollectionView!
    
    var sections: [Section] = []
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
       createCompositionLayout()
        collectionView.backgroundColor = .clear
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
       createCompositionLayout()
    }
    
    // MARK: - CompositionLayout

    private func createCompositionLayout() {
            
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            
            let section = self.sections[sectionIndex]
            
            switch section.style {
                
            case .newSong:
                return self.createNewSongSection()
            case .popularAlbum:
                return self.createPopularAlbumSection()
            case .recentlyMusic:
                return self.createRecentlyMusicSection()            }
            
        }
    
        
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        
        // MARK: - Registrate cells
        
        collectionView.register(NewSongCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(PopularAlbumCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(HeaderSeeAllView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeeAllView.identifier)
        
        
        collectionView.dataSource = self
        
        addSubview(collectionView)
    }
    
    
    func setSections(_ sections: [Section]) {
        self.sections = sections
        collectionView.reloadData()
    }

    // MARK: - Create Sections
    
    func createNewSongSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(149),
            heightDimension: .absolute(195))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemSize])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    func createPopularAlbumSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(350),
            heightDimension: .absolute(193))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemSize])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
        
    }
    
    func createRecentlyMusicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 5, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemSize])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 16)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
    
}

// MARK: - Header for sections

extension CustomeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Invalid supplementary view type")
        }
        
        let headerView: UICollectionReusableView
        
        if indexPath.section == 0 {
            headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "headerSeeAll",
                for: indexPath) as! HeaderSeeAllView
            
        } else {
            headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "Header",
                for: indexPath) as! HeaderReusableView
        }
        
        let section = sections[indexPath.section]
        
        if let headerSeeAllView = headerView as? HeaderSeeAllView {
            headerSeeAllView.configure(title: section.title, delegate: self)
        } else if let headerReusebleView = headerView as? HeaderReusableView {
            headerReusebleView.configure(title: section.title)
        }
        
        return headerView
        
    }
    
}
