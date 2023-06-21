//
//  SuggestionViewController.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 14.06.2023.
//

import UIKit

class AlbumOnlyViewController: UIViewController {
    // MARK: - let/var
    private var tracks: [SpotifySimplifiedTrack] = []
    private var currentAlbum: Album?
    
    private let idSongCell = "idSongCell"

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "suggestionBI")
        
        return imageView
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Come to me"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 38)
        
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shawn Mendes"
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        
        return label
    }()

    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "gray")
        
        return view
    }()

    private let suggestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tracks"
        label.font = UIFont(name: "Roboto-Bold", size: 20)
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        
        return label
    }()

    private let songCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    // MARK: - leftSwipe
    private lazy var leftSwipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .left
        swipe.addTarget(self, action: #selector(goToPlayVC))
        
        return swipe
    }()
    
    init(album: Album?) {
        super.init(nibName: nil, bundle: nil)
        
        if let album = album {
            self.titleLabel.text = album.name
            self.subtitleLabel.text = album.artists.first?.name
            self.tracks = album.tracks.items
            self.currentAlbum = album
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        setupViews()
        setConstrains()
        setDelegates()
        songCollectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: idSongCell)
    }
    
    // MARK: - backButtonTapped
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    // MARK: - pageControlValueChanged
    @objc private func pageControlValueChanged() {
        print("pageControlValueChanged")
    }
    // MARK: - goToPlayVC
    @objc private func goToPlayVC() {
        let playVC = PlayViewController()
        playVC.modalPresentationStyle = .fullScreen
        playVC.modalTransitionStyle = .crossDissolve
        present(playVC, animated: true)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension AlbumOnlyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 60)
    }
}
// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AlbumOnlyViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idSongCell, for: indexPath) as! SongCollectionViewCell
        cell.numberSongLabel.text = String(indexPath.row + 1)
        cell.nameSongLabel.text = tracks[indexPath.row].name
        cell.singerNameLabel.text = tracks[indexPath.row].artists.first?.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        PlaybackManager.shared.startPlayback(from: self, track: track)
    }
}
extension AlbumOnlyViewController {
    // MARK: - setDelegates
    private func setDelegates() {
        songCollectionView.delegate = self
        songCollectionView.dataSource = self
    }
    // MARK: - setupViews
    private func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(separatorLine)
        view.addSubview(suggestionLabel)
        view.addSubview(songCollectionView)
        view.addGestureRecognizer(leftSwipe)
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 242),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 36),
            separatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            separatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            suggestionLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: 40),
            suggestionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            songCollectionView.topAnchor.constraint(equalTo: suggestionLabel.bottomAnchor, constant: 22),
            songCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            songCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
