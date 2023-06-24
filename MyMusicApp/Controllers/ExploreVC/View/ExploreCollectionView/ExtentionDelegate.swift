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
            // Transition to playlist with selected genre
            let genre = genres[indexPath.row]
            APICaller.shared.getGenreTracks(for: genre) { result in
                switch result {
                case .success(let genresTracks):
                    DispatchQueue.main.async {
                        let targetVC = PlaylistOnlyViewController(playlist: nil,
                                                                  playlistsTracks: nil,
                                                                  recommendedTracks: genresTracks)
                        targetVC.modalPresentationStyle = .fullScreen
                        self.navigationController?.pushViewController(targetVC, animated: true)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
}
