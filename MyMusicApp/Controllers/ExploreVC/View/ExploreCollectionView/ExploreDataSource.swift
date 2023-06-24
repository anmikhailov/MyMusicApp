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
            return recentlyTracks.count
        case .topTrending:
            return recommendTrack.count
        case .topic:
            return genres.count
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
            
            let track = recommendTrack[indexPath.item]
           // cell.configureCell(track: recommendTrack)
            return cell
            
        case .topic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath) as? TopicCell else {
                return UICollectionViewCell()
            }
    
            let genre = genres[indexPath.row]
            cell.configureCell(image: imageCategory!, title: genre)
            return cell
        }
        
    }
}
