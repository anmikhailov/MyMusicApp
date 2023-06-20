//
//  SongCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 14.06.2023.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    // MARK: - numberSongLabel
     let numberSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "01"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        
        return label
    }()
    // MARK: - photoImageView
     let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "singerPhoto")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    // MARK: - nameSongLabel
     let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nice For What"
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        
        return label
    }()
    // MARK: - singerNameLabel
     let singerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avinci John"
        label.textColor = UIColor(red: 113, green: 115, blue: 123)
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        
        return label
    }()
    // MARK: - ellipsisButton
     lazy var ellipsisButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(ellipsisButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstrains()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - ellipsisButtonTapped
    @objc private func ellipsisButtonTapped() {
        print("ellipsisButtonTapped")
    }
    // MARK: - setupViews
     func setupViews() {
        addSubview(numberSongLabel)
        addSubview(photoImageView)
        addSubview(nameSongLabel)
        addSubview(singerNameLabel)
        addSubview(ellipsisButton)
    }
    // MARK: - setConstrains
     func setConstrains() {
        NSLayoutConstraint.activate([
            numberSongLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            numberSongLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: numberSongLabel.trailingAnchor, constant: 21),
            photoImageView.widthAnchor.constraint(equalToConstant: 37),
            photoImageView.heightAnchor.constraint(equalToConstant: 37)
        ])
        NSLayoutConstraint.activate([
            nameSongLabel.topAnchor.constraint(equalTo: topAnchor),
            nameSongLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            singerNameLabel.topAnchor.constraint(equalTo: nameSongLabel.bottomAnchor, constant: 3),
            singerNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            ellipsisButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            ellipsisButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }
}
