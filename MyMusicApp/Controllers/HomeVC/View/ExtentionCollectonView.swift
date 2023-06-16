//
//  ExtentionCollectonView.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

extension CustomeCollectionView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = sections[indexPath.section].style
        
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
