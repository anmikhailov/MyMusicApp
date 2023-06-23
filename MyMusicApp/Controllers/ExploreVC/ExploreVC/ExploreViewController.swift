//
//  ExploreViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

protocol ViewAllProtocol: AnyObject {
    func goToSeeAll()
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
    }
    
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

extension ExploreViewController: ViewAllProtocol {
    func goToSeeAll() {
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
        
        let button = playback?.playButton
        button?.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func playButtonTapped() {
        isPlaying.toggle()
        if let playerVC = presentedViewController as? PlayViewController {
            playerVC.isPlay = isPlaying
        }
        
        let buttonTitle = isPlaying ? "Stop" : "Play"
        if let playButton = playback?.subviews.compactMap({ $0 as? UIButton}).first {
            playButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    
}
