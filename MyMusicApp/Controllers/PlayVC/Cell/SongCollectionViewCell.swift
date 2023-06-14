//
//  SongCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Sergey Medvedev on 14.06.2023.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    // MARK: - numberSongLabel
    private let numberSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "01"
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Regular", size: 16)
        
        return label
    }()
    // MARK: - photoImageView
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "singerPhoto")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    // MARK: - nameSongLabel
    private let nameSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nice For What"
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        
        return label
    }()
    // MARK: - singerNameLabel
    private let singerNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avinci John"
        label.textColor = UIColor(red: 113, green: 115, blue: 123)
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        
        return label
    }()
    // MARK: - ellipsisButton
    private lazy var ellipsisButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(ellipsisButtonTapped), for: .touchUpInside)
        
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
    private func setupViews() {
        addSubview(numberSongLabel)
        addSubview(photoImageView)
        addSubview(nameSongLabel)
        addSubview(singerNameLabel)
        addSubview(ellipsisButton)
    }
    // MARK: - setConstrains
    private func setConstrains() {
        NSLayoutConstraint.activate([
            numberSongLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
        ])
    }
}
