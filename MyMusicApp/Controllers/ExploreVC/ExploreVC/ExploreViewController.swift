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
    
    let imageCategory: [UIImage] = [
            UIImage(named: "hip-hop")!,
            UIImage(named: "pop")!,
            UIImage(named: "hipnow")!,
            UIImage(named: "jazz")!,
            UIImage(named: "rb")!,
            UIImage(named: "topHits")!
        ]
    
    let post = UIImage(named: "top")
    
    private var playback: PlayView?
    
    var recentlyTracks: [PlayHistoryObject] = []
    var track: [SpotifySimplifiedTrack] = []
    var genres: [String] = []
    
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
        TopTrndinTrack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        if PlaybackManager.shared.isPlaying {
            addPlayView()
        }
    }
    
    // MARK: - Fetch Data methods
    
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
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func TopTrndinTrack() {
        APICaller.shared.getPlaylistTracks(with: "37i9dQZF1DXcBWIGoYBM5M") { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let track):
                for track in track.items {
                    self.track.append(track.track)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
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
        
    }
    
    private func setupCells() {
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(TopTrendingCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(TopicCell.self, forCellWithReuseIdentifier: "cell5")
        
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(ExploreCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreCollectionReusableView.identifier)
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
