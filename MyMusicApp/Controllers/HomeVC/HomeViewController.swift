//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

protocol GoToSeeAllProtocol: AnyObject {
    func goToSeeAll()
}

final class HomeViewController: UIViewController {
    
    // MARK: - Properties

    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = nil
        collection.bounces = false
        return collection
    }()
    
    lazy var sections: [Section] = [.newSong, .popularAlbum, .recentlyMusic]
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.TabBarColors.background
        
        // fetchNewReleasesAlbums()
        APICaller.shared.getNewReleasesAlbums(country: "US", limit: 10) { result in
            switch result {
            case .success(let albums):
                print(albums)
            case .failure(let error):
                print(error)
            }
        }
        configureNavBar(with: "Music", backgroundColor: .clear, rightButtonImage: Resources.Icons.Common.search)
        
        constraints()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCells()
        collectionView.collectionViewLayout = createCompositionLayout()
        
    }
    
    private func setupCells() {
        collectionView.register(NewSongCell.self, forCellWithReuseIdentifier: "cell1")
        collectionView.register(PopularAlbumCell.self, forCellWithReuseIdentifier: "cell2")
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(HeaderSeeAllView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSeeAllView.identifier)
    }
    
    override func barButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    private var isNavigationBarHidden = false

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 0 && !isNavigationBarHidden {
            // Scroll down, hide the navigation bar
            isNavigationBarHidden = true
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if offsetY <= 0 && isNavigationBarHidden {
            // Scroll to top, show the navigation bar
            isNavigationBarHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }


    
}

// MARK: - Constraints

extension HomeViewController {
    
    private func constraints() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension HomeViewController: GoToSeeAllProtocol {
    func goToSeeAll() {
        let tableViewController = TableNewSongViewController()
        
        navigationController?.pushViewController(tableViewController, animated: true)
    }
}

