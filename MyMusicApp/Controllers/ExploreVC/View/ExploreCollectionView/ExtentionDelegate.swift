//
//  ExtentionDelegate.swift
//  MyMusicApp
//
//  Created by mac on 6/20/23.
//

import UIKit

extension ExploreViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        switch section {
            
        case .recentlyMusic:
            let tableViewController = TableNewSongViewController()
            
            navigationController?.pushViewController(tableViewController, animated: true)
        case .topTrending:
            let tableViewController = TableNewSongViewController()
            
            navigationController?.pushViewController(tableViewController, animated: true)
        case .topic:
            
            let topicVC = TopicViewController()
            navigationController?.pushViewController(topicVC, animated: true)
        }
    }
    
    
}
