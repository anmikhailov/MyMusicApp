//
//  ExploreViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

protocol ViewAllProtocol: AnyObject {
    func goToSeeAllCategory()
}

protocol TrackListProtocol: AnyObject {
    func goToSeeAllMusic()
}

class ExploreViewController: UIViewController {
    
    // MARK: - Properties
    
    let imageCategory = UIImage(named: "hip-hop")
    
    private var playback: PlayView?
    var isPlaying = false {
        didSet {
            if isPlaying {
                addPlayView()
            }
        }
    }
    
    var recentlyTracks: [PlayHistoryObject] = []
    var genres: [String] = []
    var recommendTrack: [SpotifySimplifiedTrack] = []
    
    private let helperView = UIView()
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = nil
        collection.bounces = true
        return collection
    }()
    
    lazy var sections: [ExploreSection] = [.recentlyMusic, .topTrending, .topic]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.TabBarColors.background
        
        setupCollectionView()
        setupConstraints()
        configureNavBar(with: "Explore", backgroundColor: .clear, rightButtonImage: Resources.Icons.Common.search)
        fetchRecentlyTrack()
        fetchGenres()
        fetchGenreTracks()
    }
    
    // MARK: - Fetch Data
    
    func fetchRecentlyTrack() {
        APICaller.shared.getFiveRecentlyPlayedTracks { [weak self] result in
            switch result {
            case .success(let track):
                self?.recentlyTracks = track.items
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchGenres() {
        APICaller.shared.getGenres { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genres):
                let limitedGenres = Array(genres.genres.prefix(6))
                self.genres = limitedGenres
//                self.genres = genres.genres
//                print(genres)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchGenreTracks() {
        APICaller.shared.getGenreTracks(for: genres.first ?? "") { [weak self] result in
            switch result {
            case .success(let track):
                self?.recommendTrack = track.tracks
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
        
    }
    
    private func setupCells() {
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(TopTrendingCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(TopicCell.self, forCellWithReuseIdentifier: "cell5")
        
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(CategoryReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryReusableView.identifier)
        collectionView.register(TrackListReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TrackListReusableView.identifier)
    }
    
    override func barButtonTapped() {
        navigationController?.pushViewController(SearchViewController(), animated: true)
    }
}

extension ExploreViewController {
    
    func setupConstraints() {
        
        view.addSubview(helperView)
        helperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperView.topAnchor.constraint(equalTo: view.topAnchor),
            helperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            helperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            helperView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension ExploreViewController: ViewAllProtocol, TrackListProtocol {
    
    func goToSeeAllMusic() {
        let viewAllVC = ViewAllRecentlyMusicViewController()
        navigationController?.pushViewController(viewAllVC, animated: true)
    }
    
    func goToSeeAllCategory() {
        
        let viewAllVC = ViewAllCategoryViewController()
        navigationController?.pushViewController(viewAllVC, animated: true)
    }
    
    
}

extension ExploreViewController {
    
    private func addPlayView() {
        playback = PlayView()
        playback?.backgroundColor = Resources.Colors.brand1
        
        view.addSubview(playback!)
        playback?.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-85)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
    }
    
    
}
