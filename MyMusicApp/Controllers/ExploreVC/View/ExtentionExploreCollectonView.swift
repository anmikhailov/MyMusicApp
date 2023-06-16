//
//  ExtentionExploreCollectonView.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import UIKit

extension ExploreCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return explore.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return explore[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let explore = explore[indexPath.section].style
        
        switch explore {
            
        case .recentlyMusic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecentlyMusicCell else {
                return UICollectionViewCell()
            }
            cell.configure()
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
