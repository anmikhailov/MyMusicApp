//
//  PlayViewController.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 13.06.2023.
//

import UIKit

class PlayViewController: UIViewController {
    // MARK: - let/var
    

    // MARK: - backButton
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - albumImageView
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Album")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    // MARK: - nameSongLabel
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Come to me"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 36)
        
        return label
    }()
    // MARK: - groupNameLabel
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "One Republic"
        label.textAlignment = .center
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        
        return label
    }()
    // MARK: - textLabel
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "It is a long established fact that a reader"
        label.textAlignment = .center
        label.textColor = UIColor(named: "green")
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        
        return label
    }()
    // MARK: - sharedButton
    private lazy var sharedButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action: #selector(sharedButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - playlistAddButton
    private lazy var playlistAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "playlistAdd"), for: .normal)
        button.addTarget(self, action: #selector(playlistAddButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - favoriteButton
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "favorite2"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - downloadButton
    private lazy var downloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "download"), for: .normal)
        button.addTarget(self, action: #selector(downloadButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - mainStackView
    private var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 63
        stackView.axis = .horizontal
        
        return stackView
    }()
    // MARK: - songTimeSlider
    private lazy var songTimeSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 50
        slider.minimumTrackTintColor = UIColor(named: "green")
        slider.maximumTrackTintColor = UIColor(named: "gray")
        slider.setThumbImage(UIImage(named: "Circle"), for: .normal)
        slider.addTarget(self, action: #selector(songTimeSliderTapped), for: .valueChanged)
        
        return slider
    }()
    // MARK: - songStart
    private let songStartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .white
        label.text = "2:46"
        
        return label
    }()
    // MARK: - songEndLabel
    private let songEndLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = .white
        label.text = "3:05"
        
        return label
    }()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setConstrains()
    }
    // MARK: - sharedButtonTapped
    @objc private func sharedButtonTapped() {
        print("sharedButtonTapped")
    }
    // MARK: - backButtonTapped
    @objc private func backButtonTapped() {
        print("backButtonTapped")
    }
    // MARK: - playlistAddButtonTapped
    @objc private func playlistAddButtonTapped() {
        print("playlistAddButtonTapped")
    }
    // MARK: - favoriteButtonTapped
    @objc private func favoriteButtonTapped() {
        print("favoriteButtonTapped")
    }
    // MARK: - downloadButtonTapped
    @objc private func downloadButtonTapped() {
        print("downloadButtonTapped")
    }
    // MARK: - songTimeSliderTapped
    @objc private func songTimeSliderTapped() {
        print("songTimeSliderTapped")
    }
    // MARK: - setupViews
    private func setupViews() {
        view.backgroundColor = .black
        
        view.addSubview(backButton)
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
                
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
        ])
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 145),
            albumImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            albumImageView.heightAnchor.constraint(equalToConstant: 207),
        ])
        NSLayoutConstraint.activate([
            songNameLabel.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 22),
            songNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
            songTimeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23)
        ])
        NSLayoutConstraint.activate([
            songStartLabel.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor, constant: 13),
            songStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23)
        ])
        NSLayoutConstraint.activate([
            songEndLabel.topAnchor.constraint(equalTo: songTimeSlider.bottomAnchor, constant: 13),
            songEndLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -23)
        ])

    }
}
