//
//  PlayViewController.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 13.06.2023.
//

import UIKit

class PlayViewController: UIViewController {
    // MARK: - let/var
    let notificationManager = NotificationManager()
    
    var isFavorite = false
    private var isDownload = false
    var isPlay = false {
        didSet {
            if isPlay {
                playButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            } else {
                playButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
                playButton.backgroundColor = .none
            }
        }
    }

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.tintColor = .red
        pageControl.numberOfPages = 2
        pageControl.currentPage = 1
        pageControl.isUserInteractionEnabled = false
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        return pageControl
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Album")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()

    let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Come to me"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 36)
        
        return label
    }()

    let groupNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "One Republic"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        
        return label
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .center
        label.textColor = Resources.Colors.brand1
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        
        return label
    }()

    private lazy var sharedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(sharedButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private lazy var playlistAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "playlistAdd"), for: .normal)
        button.addTarget(self, action: #selector(playlistAddButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "download"), for: .normal)
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 63
        stackView.axis = .horizontal
        
        return stackView
    }()

    lazy var songTimeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.minimumTrackTintColor = Resources.Colors.brand1
        slider.maximumTrackTintColor = Resources.Colors.neutral2
        slider.setThumbImage(UIImage(named: "Circle"), for: .normal)
        slider.addTarget(self, action: #selector(songTimeSliderValueChanged(_:)), for: .valueChanged)
        
        return slider
    }()

    let songStartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .white
        label.text = "2:46"
        
        return label
    }()

    let songEndLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .white
        label.text = "3:05"
        
        return label
    }()

    private lazy var shuffleButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "shuffle"), for: .normal)
        button.addTarget(self, action: #selector(shuffleButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private lazy var previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private lazy var circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "green")
        view.layer.cornerRadius = view.frame.width / 2
        
        return view
    }()

    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "next"), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private lazy var repeatButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "loop"), for: .normal)
        button.addTarget(self, action: #selector(repeatButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()

    private lazy var rightSwipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .right
        swipe.addTarget(self, action: #selector(goToAlbumVC))
        
        return swipe
    }()
    
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstrains()
        
        notificationManager.userNotificationPermission()
        notificationManager.notificationCenter.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        isFavorite = PlaybackManager.shared.hasCurrentTrackInStorange()
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = Resources.Colors.brand1
            
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
        }
    }
    
    override func viewDidLayoutSubviews() {
        circleView.layer.cornerRadius = circleView.frame.width / 2
    }
    // MARK: - sharedButtonTapped
    @objc private func sharedButtonTapped() {
        let items:[Any] = [URL(string: "https://apple.com")!]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        self.present(avc, animated: true)
    }
    // MARK: - backButtonTapped
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    // MARK: - playlistAddButtonTapped
    @objc private func playlistAddButtonTapped() {
        print("playlistAddButtonTapped")
    }
    // MARK: - favoriteButtonTapped
    @objc private func favoriteButtonTapped() {
        if !isFavorite {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.tintColor = Resources.Colors.brand1
            isFavorite = false
            PlaybackManager.shared.saveCurrentTrack()
            isFavorite = true
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.tintColor = .white
            PlaybackManager.shared.deleteCurrentTrack()
            isFavorite = false
        }
    }
    // MARK: - downloadButtonTapped
    @objc private func downloadButtonTapped() {
        if !isDownload {
            PlaybackManager.shared.downloadTrack()
            notificationManager.sendNotification(title: "Track has been downloaded!", body: "You can listen it from Account -> Downloaded Tracks")
            downloadButton.tintColor = Resources.Colors.brand1
            isDownload = true
        } else {
            
            downloadButton.tintColor = .white
            isDownload = false
        }
    }
    // MARK: - songTimeSliderValueChanged
    @objc private func songTimeSliderValueChanged(_ sender: UISlider) {
        let timeStamp = Int64(sender.value)
        PlaybackManager.shared.seekTrack(to: timeStamp)
    }
    // MARK: - shuffleButtonTapped
    @objc private func shuffleButtonTapped() {
        print("shuffleButtonTapped")
    }
    // MARK: - previousButtonTapped
    @objc private func previousButtonTapped() {
        PlaybackManager.shared.backwardPlayback()
    }
    // MARK: - playButtonTapped
    @objc private func playButtonTapped() {
        isPlay.toggle()
        PlaybackManager.shared.playPausePlayback()
    }
    // MARK: - nextButtonTapped
    @objc private func nextButtonTapped() {
        PlaybackManager.shared.forwardPlayback()
    }
    // MARK: - repeatButtonTapped
    @objc private func repeatButtonTapped() {
        print("repeatButtonTapped")
    }
    // MARK: - pageControlValueChanged
    @objc func pageControlValueChanged() {
//        let currentPage = pageControl.currentPage
//
//        let albumVC = AlbumViewController()
//        present(albumVC, animated: true)
        print("pageControlValueChanged")
    }
    // MARK: - rightSwipeDoing
    @objc private func goToAlbumVC() {
        let albumVC = AlbumViewController()
        albumVC.modalPresentationStyle = .fullScreen
        albumVC.modalTransitionStyle = .crossDissolve
        present(albumVC, animated: true)
    }
}
extension PlayViewController {
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = Resources.Colors.TabBarColors.background
                
        view.addSubview(backButton)
        view.addSubview(pageControl)
        view.addSubview(albumImageView)
        view.addSubview(songNameLabel)
        view.addSubview(groupNameLabel)
        view.addSubview(textLabel)
        
        mainStackView.addArrangedSubview(sharedButton)
        mainStackView.addArrangedSubview(playlistAddButton)
        mainStackView.addArrangedSubview(favoriteButton)
        mainStackView.addArrangedSubview(downloadButton)

        view.addSubview(mainStackView)
        view.addSubview(songTimeSlider)
        view.addSubview(songStartLabel)
        view.addSubview(songEndLabel)
        view.addSubview(shuffleButton)
        view.addSubview(previousButton)
        view.addSubview(circleView)
        
        circleView.addSubview(playButton)
        
        view.addSubview(nextButton)
        view.addSubview(repeatButton)
        view.addGestureRecognizer(rightSwipe)
                    
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
        ])
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 32),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 52),
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.heightAnchor.constraint(equalToConstant: 207),
        ])
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 22),
            songNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            songNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            groupNameLabel.topAnchor.constraint(equalTo: songNameLabel.bottomAnchor, constant: 4),
            groupNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 22),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            songTimeSlider.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 46),
            songTimeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            songTimeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23),
        ])
        NSLayoutConstraint.activate([
            songStartLabel.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor, constant: 13),
            songStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23)
        ])
        NSLayoutConstraint.activate([
            songEndLabel.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor, constant: 13),
            songEndLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23)
        ])
        NSLayoutConstraint.activate([
            shuffleButton.topAnchor.constraint(equalTo: songStartLabel.bottomAnchor, constant: 47),
            shuffleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            previousButton.topAnchor.constraint(equalTo: songStartLabel.bottomAnchor, constant: 47),
            previousButton.leadingAnchor.constraint(equalTo: shuffleButton.trailingAnchor, constant: 50)
        ])
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: songStartLabel.bottomAnchor, constant: 22),
            circleView.leadingAnchor.constraint(equalTo: previousButton.trailingAnchor, constant: 45),
            circleView.widthAnchor.constraint(equalToConstant: 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
        ])
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 25),
            playButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: songStartLabel.bottomAnchor, constant: 46),
            nextButton.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 39)
        ])
        NSLayoutConstraint.activate([
            repeatButton.topAnchor.constraint(equalTo: songStartLabel.bottomAnchor, constant: 47),
            repeatButton.leadingAnchor.constraint(equalTo: nextButton.trailingAnchor, constant: 46)
        ])
    }
}

// MARK: - Notifications delegate
extension PlayViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function)
        //user tap on badge and go to the screen we need using TabBarController
    }
    
}
