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
//    var newAlbums: [NewAlbum] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.TabBarColors.background
        setupCollectionView()
        setupConstraints()
        
        // fetchNewReleasesAlbums()
        APICaller.shared.getNewReleasesAlbums(country: "US", limit: 10) { result in
            switch result {
            case .success(let albums):
                print(albums)
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func fetchNewReleasesAlbums() {
//        let networkService = DefaultNetworkService()
//        let request = NewReleasesAlbumRequest(country: "DE", limit: 50, offset: 0)
//        networkService.request(request) { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let albums):
//                guard let albums = albums else { return }
//                self.newAlbums = albums
//            case .failure(let error):
//                fatalError("\(error)")
//            }
//        }
//
//    }
    
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
