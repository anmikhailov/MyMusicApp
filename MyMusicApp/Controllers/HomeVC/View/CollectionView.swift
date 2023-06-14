//
//  CollectionView.swift
//  MyMusicApp
//
//  Created by mac on 6/13/23.
//

import UIKit

class CollectionView: UIView {

    private var collectionView: UICollectionView!
    private var sections: [Section] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        
       createCompositionLayout()
        
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
        
        collectionView.register(NewSongCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(PopularAlbumCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
        
    }
    
    func createRecentlyMusicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemSize])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return section
    }
    
}

extension CollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.section].style
        
        switch section {
            
        case .newSong:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? NewSongCell else {
                return UICollectionViewCell()
            }
            cell.configure()
            return cell
            
        case .popularAlbum:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? PopularAlbumCell else {
                return UICollectionViewCell()
            }
            cell.configureCell()
            return cell
            
        case .recentlyMusic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecentlyMusicCell else {
                return UICollectionViewCell()
            }
            cell.configure()
            return cell
        }
        
    }
    
    
}
