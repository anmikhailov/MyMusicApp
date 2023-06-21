//
//  SuggestionViewController.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 14.06.2023.
//

import UIKit

class AlbumViewController: UIViewController {
    // MARK: - let/var
 static let idSongCell = "idSongCell"
    // MARK: - backgroundImageView
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "suggestionBI")
        
        return imageView
    }()
    // MARK: - backButton
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - pageController
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.tintColor = .red
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        return pageControl
    }()
    // MARK: - titleLabel
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Come to me"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 38)
        
        return label
    }()
    // MARK: - subtitleLabel
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shawn Mendes"
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 20)
        
        return label
    }()
    // MARK: - textView
    private var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it"
        textView.textColor = UIColor(red: 238, green: 238, blue: 238)
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        textView.font = UIFont(name: "Roboto-Regular", size: 16)
        
        return textView
    }()
    // MARK: - separatorLine
    private let separatorLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "gray")
        
        return view
    }()
    // MARK: - suggestionLabel
    private let suggestionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Suggestion"
        label.font = UIFont(name: "Roboto-Bold", size: 20)
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        
        return label
    }()
    // MARK: - songCollectionView
     let songCollectionView: UICollectionView = {
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
    // MARK: - lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstrains()
        setDelegates()
        songCollectionView.register(SongCollectionViewCell.self, forCellWithReuseIdentifier: AlbumViewController.idSongCell)
    }
    
    // MARK: - backButtonTapped
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    // MARK: - pageControlValueChanged
    @objc private func pageControlValueChanged() {
        print("pageControlValueChanged")
    }
    // MARK: - goToPlayVC
    @objc private func goToPlayVC() {
//        let playVC = PlayViewController()
//        playVC.modalPresentationStyle = .fullScreen
//        playVC.modalTransitionStyle = .crossDissolve
//        present(playVC, animated: true)
        dismiss(animated: true)
    }
}
// MARK: - UICollectionViewDelegateFlowLayout
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: 60)
    }
}
// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumViewController.idSongCell, for: indexPath) as! SongCollectionViewCell
        
        return cell
    }
}
extension AlbumViewController {
    // MARK: - setDelegates
     func setDelegates() {
        songCollectionView.delegate = self
        songCollectionView.dataSource = self
    }
    // MARK: - setupViews
     func setupViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(textView)
        view.addSubview(separatorLine)
        view.addSubview(suggestionLabel)
        view.addSubview(songCollectionView)
        view.addSubview(pageControl)
        view.addGestureRecognizer(leftSwipe)
    }
    // MARK: - setConstrains
     func setConstrains() {
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
            pageControl.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            textView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            textView.heightAnchor.constraint(equalToConstant: 72)
        ])
        NSLayoutConstraint.activate([
            separatorLine.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 36),
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
