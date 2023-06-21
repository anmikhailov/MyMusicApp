//
//  ExploreDataSource.swift
//  MyMusicApp
//
//  Created by mac on 6/20/23.
//

import UIKit

extension ExploreViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
            
        case .recentlyMusic:
            return 5
        case .topTrending:
            return 3
        case .topic:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.section]
        
        switch section {
            
        case .recentlyMusic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecentlyMusicCell else {
                return UICollectionViewCell()
            }
            
            let track = recentlyTracks[indexPath.item]
            cell.configure(recentlyMusic: track)
            cell.backgroundColor = Resources.Colors.TabBarColors.backgraundCell
            return cell
            
        case .topTrending:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath) as? TopTrendingCell else {
                return UICollectionViewCell()
            }
            cell.configureCell()
            return cell
            
        case .topic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as? TopicCell else {
                return UICollectionViewCell()
            }
    
            cell.configureCell()
            return cell
        }
        
    }
}
