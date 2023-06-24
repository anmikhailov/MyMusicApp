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
            let track = recentlyTracks[indexPath.row].track
            PlaybackManager.shared.startPlayback(from: self, track: track)
        case .topTrending:
            let track = track[indexPath.row]
            PlaybackManager.shared.startPlayback(from: self, track: track)
        case .topic:
            let topicVC = TopicViewController()
            navigationController?.pushViewController(topicVC, animated: true)
        }
    }
    
    
}
