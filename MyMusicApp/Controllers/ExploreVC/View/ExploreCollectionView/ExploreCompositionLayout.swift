//
//  ExploreCompositionLayout.swift
//  MyMusicApp
//
//  Created by mac on 6/20/23.
//

import UIKit

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    
    func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
             sectionIndex, layoutEnvironment in
            
            let section = self.sections[sectionIndex]
            
            switch section {
                
            case .recentlyMusic:
                return self.createRecentlyMusicSection()
            case .topTrending:
                return self.createTopTrendingSection()
            case .topic:
                return self.createTopicSection()
            }
        }
    }
    
    private func createSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
        contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = behavior
            section.interGroupSpacing = interGroupSpacing
            section.boundarySupplementaryItems = supplementaryItems
            section.supplementariesFollowContentInsets = contentInsets
            return section
    }
    
    private func createRecentlyMusicSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 5, leading: 10, bottom: 10, trailing: 0)
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    func createTopTrendingSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 5, leading: 16, bottom: 0, trailing: 20)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .absolute(340), heightDimension: .absolute(193)),
            subitems: [item])
        
        let section = createSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 30,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false)
        section.contentInsets = .init(top: 5, leading: 20, bottom: 10, trailing: 5)
        return section
    }

    func createTopicSection() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 10)
        
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = createSection(
            group: group,
            behavior: .none,
            interGroupSpacing: 10,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
         }
    
    
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
            .init(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(30)),
                  elementKind: UICollectionView.elementKindSectionHeader,
                  alignment: .top)
        }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Invalid supplementary view type")
        }
        
        let headerView: UICollectionReusableView
        
        if indexPath.section == 0 {
            headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderList",
                               for: indexPath) as! TrackListReusableView

        } else if indexPath.section == 2 {
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
        

        
        let explore = sections[indexPath.section]
        
        if let headerSeeAllView = headerView as? ExploreCollectionReusableView {
            headerSeeAllView.configure(title: explore.title, delegate: self)
        } else if let headerReusebleView = headerView as? HeaderReusableView {
            headerReusebleView.configure(title: explore.title)
        } else if let headerRecentlyMusic = headerView as? TrackListReusableView {
            headerRecentlyMusic.configure(title: explore.title, delegate: self)
        }

        return headerView
        
    }
    
}


