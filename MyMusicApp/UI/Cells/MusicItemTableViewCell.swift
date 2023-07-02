//
//  MusicItemTableViewCell.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import UIKit

class MusicItemTableViewCell: UITableViewCell {
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral1
        label.font = Resources.Fonts.RobotoRegular(with: 16)
        label.textAlignment = .left
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .neutral2
        label.font = Resources.Fonts.RobotoRegular(with: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var bottomSeparator: UIImageView = {
        let element = UIImageView()
        element.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        element.backgroundColor = .neutral2
        return element
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addView(photoImageView)
        addView(titleLabel)
        addView(subtitleLabel)
        addView(bottomSeparator)
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            photoImageView.widthAnchor.constraint(equalToConstant: 37),
            photoImageView.heightAnchor.constraint(equalToConstant: 37),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            subtitleLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func cellConfigure(with image: UIImage?, title: String, subtitle: String?) {
        photoImageView.image = image
        titleLabel.text = title
        subtitleLabel.text = subtitle ?? ""
    }
}
