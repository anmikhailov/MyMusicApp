//
//  Extention+DataSource.swift
//  MyMusicApp
//
//  Created by mac on 6/19/23.
//

import UIKit
import SnapKit

extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
            
        case .newSong:
            return 5
        case .popularAlbum:
            return 1
        case .recentlyMusic:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.section]
        
        switch section {
            
        case .newSong:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? NewSongCell else {
                return UICollectionViewCell()
            }
            cell.configure()
            return cell
            
        case .popularAlbum:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? PopularAlbumCell else {
                return UICollectionViewCell()
            }
            cell.configureCell()
            return cell
            
        case .recentlyMusic:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecentlyMusicCell else {
                return UICollectionViewCell()
            }
            cell.configure()
            return cell
        }
        
    }
}
