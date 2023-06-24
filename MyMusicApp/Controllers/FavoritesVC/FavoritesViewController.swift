//
//  FavoritesViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import RealmSwift

class FavoritesViewController: UIViewController {
    // MARK: - let/var
    let realm = try! Realm()
    var favoritesSongsArray: [SpotifySimplifiedTrack] = []
    var filteredArray: [SpotifySimplifiedTrack] = []
    // MARK: - songLabel
    private let songLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SONG"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 20)

        return label
    }()
    // MARK: - searchBar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.searchTextField.textColor = .white
        searchBar.layer.cornerRadius = 10
        searchBar.layer.borderWidth = 1

        return searchBar
    }()
    // MARK: - songCollectionView
     let favoritesSongsCollectionView: UICollectionView = {
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
        favoritesSongsArray =  StorageManager.shared.retrieveAll()
        filteredArray = favoritesSongsArray
        favoritesSongsCollectionView.reloadData()
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 60)
    }
}
// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "idSongCell", for: indexPath) as! SongCollectionViewCell
        let model = filteredArray[indexPath.row]
        cell.cellConfigure(model: model)
        cell.numberSongLabel.text = String(indexPath.row + 1)
        cell.delegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = filteredArray[indexPath.row]
        PlaybackManager.shared.startPlayback(from: self, track: track)
    }
}
extension FavoritesViewController: SongCollectionViewCellDelegate {
    func songCollectionViewCellDelegate(_ view: SongCollectionViewCell, didTapDotsButton button: UIButton) {
        // Alert controller for delete item
        let alertController = UIAlertController(title: "Delete track",
                                                message: "Do you want to delete this track?",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: .destructive){ (action) in
            // Delete item
            guard let indexPath = self.favoritesSongsCollectionView.indexPath(for: view) else { return }
            StorageManager.shared.deleteItem(by: self.filteredArray[indexPath.row].id)
            self.filteredArray.remove(at: indexPath.item)
            self.favoritesSongsCollectionView.reloadData()
          }
        
        )
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
}
extension FavoritesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text
        filteredArray = []
        
        for track in favoritesSongsArray {
            if track.name.contains(query!) {
                filteredArray.append(track)
            }
        }
        favoritesSongsCollectionView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        }
    }
    @objc func cancelButtonClicked() {
        filteredArray = favoritesSongsArray
        favoritesSongsCollectionView.reloadData()
    }
}
extension FavoritesViewController {
    // MARK: - setDelegates
    private func setDelegates() {
        favoritesSongsCollectionView.delegate = self
        favoritesSongsCollectionView.dataSource = self
        searchBar.delegate = self
    }
    // MARK: - setConstrains
    private func setupViews() {
        view.backgroundColor = Resources.Colors.TabBarColors.background
            
        view.addSubview(songLabel)
        view.addSubview(searchBar)
        view.addSubview(favoritesSongsCollectionView)
        favoritesSongsCollectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: "idSongCell")
        
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            songLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            songLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 190)
        ])
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: songLabel.bottomAnchor, constant: 32),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        NSLayoutConstraint.activate([
            favoritesSongsCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 34),
            favoritesSongsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoritesSongsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoritesSongsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
