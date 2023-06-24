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

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    
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
    
    // MARK: - backButtonTapped
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
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
        
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = downloadedSongsArray[indexPath.row]
        let fileURL = URL(fileURLWithPath: track.preview_url ?? "")
        let fileName = fileURL.lastPathComponent

        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found")
            return
        }

        let filePath = documentsDirectory.appendingPathComponent(fileName)
        let url = URL(fileURLWithPath: filePath.path)
        let urlString = url.absoluteString
        PlaybackManager.shared.startPlayback(from: self, track: SpotifySimplifiedTrack(artists: [SpotifySimplifiedArtist(external_urls: SpotifyExternalUrl(spotify: ""), href: "", id: "", name: track.artists.first!.name, type: "", uri: "")], duration_ms: 0, href: "", id: track.id, name: track.name, preview_url: urlString, uri: ""))
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
            
        view.addSubview(backButton)
        view.addSubview(songLabel)
        view.addSubview(downloadedSongsCollectionView)
        downloadedSongsCollectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: "idSongCell")
        
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
        ])
        
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

extension DownloadedViewController: SongCollectionViewCellDelegate {
    func songCollectionViewCellDelegate(_ view: SongCollectionViewCell, didTapDotsButton button: UIButton) {
        // Alert controller for delete item
        let alertController = UIAlertController(title: "Delete track",
                                                message: "Do you want to delete this track?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive){ (action) in
            // Delete item
            guard let indexPath = self.downloadedSongsCollectionView.indexPath(for: view) else { return }
            self.deleteFileFromDocuments(with: self.downloadedSongsArray[indexPath.row].preview_url ?? "")
            StorageManager.shared.deleteItem(by: self.downloadedSongsArray[indexPath.row].id)
            self.downloadedSongsArray.remove(at: indexPath.item)
            self.downloadedSongsCollectionView.reloadData()
          }
        
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    func deleteFileFromDocuments(with url: String) {
        let fileURL = URL(fileURLWithPath: url)
        let fileName = fileURL.lastPathComponent
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first

        if let fileURL = documentsDirectory?.appendingPathComponent(fileName) {
            do {
                try fileManager.removeItem(at: fileURL)
                print("Файл успешно удален.")
            } catch {
                print("Ошибка при удалении файла: \(error)")
            }
        }
    }
}
