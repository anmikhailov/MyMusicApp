//
//  ViewAllRecentlyMusicViewController.swift
//  MyMusicApp
//
//  Created by mac on 6/25/23.
//

import UIKit

import UIKit


class ViewAllRecentlyMusicViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var playback: PlayView?
    var isPlaying = false {
        didSet {
            if isPlaying {
                addPlayView()
            }
        }
    }
    
    var recentlyTracks: [PlayHistoryObject] = []
    
    // MARK: - Init

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 80)
        
        super.init(collectionViewLayout: layout)
        
        fetchRecentlyTrack()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")

    }
    
    // MARK: - Fetch data
    
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
    
    // MARK: - Create collection View
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 350, height: 80)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.minimumLineSpacing = 20
        return flowLayout
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentlyTracks.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as? RecentlyMusicCell else {
            return UICollectionViewCell()
        }
    
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        let track = recentlyTracks[indexPath.item]
        cell.configure(recentlyMusic: track)
        cell.backgroundColor = Resources.Colors.TabBarColors.backgraundCell
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = recentlyTracks[indexPath.item].track
        PlaybackManager.shared.startPlayback(from: self, track: track)
    }


}

// MARK: - Play View
extension ViewAllRecentlyMusicViewController {
    
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
