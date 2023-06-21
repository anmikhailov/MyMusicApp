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
    
    var album: [NewAlbum] = []
    var recentlyTracks: [PlayHistoryObject] = []
    
    // MARK: - Properties
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = nil
        collection.bounces = true
        return collection
    }()
    
    lazy var sections: [Section] = [.newSong, .popularAlbum, .recentlyMusic]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.TabBarColors.background
        configureNavBar(with: "Music", backgroundColor: .clear, rightButtonImage: Resources.Icons.Common.search)
        
        constraints()
        setupCollectionView()
        fetchMusic()
        fetchrecentlyTrack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Fetch Data
    
    func fetchMusic() {
        APICaller.shared.getNewReleasesAlbums(country: "US", limit: 10) { result in
            switch result {
            case .success(let albums):
                self.album = albums.albums.items
                DispatchQueue.main.async {
                    self.collectionView.reloadSections(IndexSet(integer: 0))
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchrecentlyTrack() {
        APICaller.shared.getFiveRecentlyPlayedTracks { [weak self] result in
            switch result {
            case .success(let track):
                self?.recentlyTracks = track.items
                DispatchQueue.main.async {
                    self?.collectionView.reloadSections(IndexSet(integer: 2))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Private methods
    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCells()
        collectionView.collectionViewLayout = createCompositionLayout()
        collectionView.bounces = true
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
    /*
    private var isNavigationBarHidden = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > 0 && !isNavigationBarHidden {
            isNavigationBarHidden = true
            navigationController?.setNavigationBarHidden(true, animated: true)
        } else if offsetY <= 0 && isNavigationBarHidden {
            isNavigationBarHidden = false
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    */
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

extension HomeViewController: ButtonTapDelegate {
    func didTapButton(at indexPath: IndexPath) {
        
        guard let tabBarController = tabBarController as? TabBarController else {
            return
        }
        tabBarController.selectedIndex = Tabs.explore.rawValue
    }
}

// MARK: - Play View
extension HomeViewController {
    
    func showPlaybackBar(with trackName: String) {
        let playbackBarHeight: CGFloat = 70
        let frame = CGRect(x: 0, y: (view.bounds.height - playbackBarHeight), width: view.bounds.width, height: playbackBarHeight)
        let playBack = PlayView(frame: frame)
        
        playBack.songNameLabel.text = trackName
        
        // прописать addTarget для каждой кнопки
        
        view.addSubview(playBack)
    }
    
}

