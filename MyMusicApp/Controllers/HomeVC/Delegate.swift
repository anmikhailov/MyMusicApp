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
           // let selectedSong = recentlyTracks[indexPath.item]
            navigationController?.pushViewController(PlayViewController(), animated: true)
        }
    }
    
    func navigationToDetail(with album: NewAlbum) {
//       let newAlbum = albumInfo(
//            albumName: album.name,
//            singerName: album.artists?.first?.name ?? "",
//            description: "",
//            image: "")
        
        let albumVC = AlbumOnlyViewController(album: nil)
        navigationController?.pushViewController(albumVC, animated: true)
    }
}
