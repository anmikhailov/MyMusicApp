//
//  Extention+CompositionLayout.swift
//  MyMusicApp
//
//  Created by mac on 6/19/23.
//

import UIKit

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func createCompositionLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout {
             sectionIndex, layoutEnvironment in
            //guard let self = self else { return }
            
            let section = self.sections[sectionIndex]
            
            switch section {
                
            case .newSong:
                return self.createNewSongSection()
            case .popularAlbum:
                return self.createPopularAlbumSection()
            case .recentlyMusic:
                return self.createRecentlyMusicSection()
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
    
    private func createNewSongSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .absolute(150), heightDimension: .absolute(200)),
            subitems: [item])
        
        let section = createSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 16,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false)
        section.contentInsets = .init(top: 13, leading: 10, bottom: 10, trailing: 0)
        return section
    }
    
    func createPopularAlbumSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .absolute(340), heightDimension: .absolute(193)),
            subitems: [item])
        
        let section = createSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 16,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false)
        section.contentInsets = .init(top: 13, leading: 20, bottom: 10, trailing: 0)
        return section
    }

    func createRecentlyMusicSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 13, leading: 16, bottom: 20, trailing: 0)
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

