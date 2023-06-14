//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private var collectionView: CollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()

    }
    
    private func setupCollectionView() {
        let sectionNewSong = Section(title: "New Song", items: [""], style: .newSong)
        let sectionPopularAlbum = Section(title: "Popular Album", items: [""], style: .popularAlbum)
        let sectionRecentlyMusic = Section(title: "Recently Music", items: [""], style: .recentlyMusic)
        
        let sections = [sectionNewSong, sectionPopularAlbum, sectionRecentlyMusic]
        
        collectionView = CollectionView(frame: view.bounds)
        
        collectionView.setSections(sections)
        
        // setup constraint
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}
