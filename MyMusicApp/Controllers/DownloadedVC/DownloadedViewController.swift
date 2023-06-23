//
//  DownloadedViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 23.06.2023.
//

import UIKit

class DownloadedViewController: UIViewController {
    // MARK: - let/var
    var downloadedSongsArray: [SpotifySimplifiedTrack] = []

    private let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SONG"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 20)

        return label
    }()

     let downloadedSongsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear

        return collectionView
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
        setDelegates()
    }
    override func viewWillAppear(_ animated: Bool) {
        downloadedSongsArray = StorageManager.shared.retrieveDownloaded()
        downloadedSongsCollectionView.reloadData()
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension DownloadedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 60)
    }
}
// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension DownloadedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        downloadedSongsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idSongCell", for: indexPath) as! SongCollectionViewCell
        let model = downloadedSongsArray[indexPath.row]
        cell.cellConfigure(model: model)
        cell.numberSongLabel.text = String(indexPath.row + 1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = downloadedSongsArray[indexPath.row]
        PlaybackManager.shared.startPlayback(from: self, track: track)
//        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            print("Documents directory not found")
//            return
//        }
//
//        let filePath = documentsDirectory.appendingPathComponent("7b5d54ffb3c4e5c28adafe19532de22508d62851.mp3")
//        let url = URL(fileURLWithPath: filePath.path)
//        let urlString = url.absoluteString
//        PlaybackManager.shared.startPlayback(from: self, track: SpotifySimplifiedTrack(artists: [SpotifySimplifiedArtist(external_urls: SpotifyExternalUrl(spotify: ""), href: "", id: "", name: track.artists.first!.name, type: "", uri: "")], duration_ms: 0, href: "", id: track.id, name: track.name, preview_url: urlString, uri: ""))
    }
}
extension DownloadedViewController {
    // MARK: - setDelegates
    private func setDelegates() {
        downloadedSongsCollectionView.delegate = self
        downloadedSongsCollectionView.dataSource = self
    }
    // MARK: - setConstrains
    private func setupViews() {
        view.backgroundColor = Resources.Colors.TabBarColors.background
            
        view.addSubview(songLabel)
        view.addSubview(downloadedSongsCollectionView)
        downloadedSongsCollectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: "idSongCell")
        
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            songLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            songLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 190)
        ])
        NSLayoutConstraint.activate([
            downloadedSongsCollectionView.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 34),
            downloadedSongsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            downloadedSongsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            downloadedSongsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
