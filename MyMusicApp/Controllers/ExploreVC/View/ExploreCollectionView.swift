//
//  ExploreCollectionView.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import UIKit

class ExploreCollectionView: UIView {

    // MARK: - Properties

    var collectionView: UICollectionView!
    var explore: [ExploreSection] = []
    
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
            
            let explore = self.explore[sectionIndex]
            
            switch explore.style {
                
            case .recentlyMusic:
                return self.createRecentlySection()
            case .topTrending:
                return self.createTopTrendingSection()
            case .topic:
                return self.createTopicSection()
            }
            
        }
    
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        
        // MARK: - Registrate cells
        
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(TopTrendingCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(TopicCell.self, forCellWithReuseIdentifier: "cell5")
    
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(ExploreCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreCollectionReusableView.identifier)
        
    
        collectionView.dataSource = self
        
        addSubview(collectionView)
    }
    
    
    func setSections(_ explore: [ExploreSection]) {
        self.explore = explore
        collectionView.reloadData()
    }

    // MARK: - Create Sections
    
    func createRecentlySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(360),
            heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [itemSize])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 3, bottom: 10, trailing: 5)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    func createTopTrendingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(350),
            heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemSize])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
        
    }
    
    func createTopicSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(60)))
        itemSize.contentInsets = .init(top: 0, leading: 0, bottom: 10, trailing: 16)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(160))
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

extension ExploreCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Invalid supplementary view type")
        }
        
        let headerView: UICollectionReusableView
        
        if indexPath.section == 0 || indexPath.section == 2 {
            headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderSeeAll",
                for: indexPath) as! ExploreCollectionReusableView
            
        } else {
            headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "Header",
                for: indexPath) as! HeaderReusableView
        }
        
        let explore = explore[indexPath.section]
        
        if let headerSeeAllView = headerView as? ExploreCollectionReusableView {
            headerSeeAllView.configure(title: explore.title, delegate: self)
        } else if let headerReusebleView = headerView as? HeaderReusableView {
            headerReusebleView.configure(title: explore.title)
        }
        
        return headerView
        
    }
    
}

