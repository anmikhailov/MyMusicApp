//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

protocol GoToSeeAllProtocol {
    func goToSeeAll()
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private var collectionView: CustomeCollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.TabBarColors.background
        setupCollectionView()
        setupConstraints()
    }
    
    // MARK: - Private methods
    
    private func setupCollectionView() {
        let sectionNewSong = Section(title: "New Song", items: [""], style: .newSong)
        let sectionPopularAlbum = Section(title: "Popular Album", items: [""], style: .popularAlbum)
        let sectionRecentlyMusic = Section(title: "Recently Music", items: [""], style: .recentlyMusic)
        
        let sections = [sectionNewSong, sectionPopularAlbum, sectionRecentlyMusic]
        
        collectionView = CustomeCollectionView(frame: view.bounds)
        collectionView.setSections(sections)
    
    }
}

// MARK: - Constraints

extension HomeViewController {
    
    private func setupConstraints() {
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
}

