//
//  Delegate.swift
//  MyMusicApp
//
//  Created by mac on 6/21/23.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = sections[indexPath.section]
        
        switch section {
            
        case .newSong:
            let selectedAlbum = album[indexPath.item]
            navigationToDetail(with: selectedAlbum)
        case .popularAlbum:
            return
        case .recentlyMusic:
            let track = recentlyTracks[indexPath.row].track
            PlaybackManager.shared.startPlayback(from: self, track: track)
        }
    }
    
    func navigationToDetail(with album: NewAlbum) {
        let albumId = album.id
        APICaller.shared.getAlbum(with: albumId) { result in
            switch result {
            case .success(let album):
                DispatchQueue.main.async {
                    let targetVC = AlbumOnlyViewController(album: album)
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
