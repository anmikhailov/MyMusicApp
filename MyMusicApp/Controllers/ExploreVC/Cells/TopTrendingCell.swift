//
//  TopTrendingCell.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import UIKit

class TopTrendingCell: UICollectionViewCell {
    
    let post = UIImage(named: "top")
    
    private let songImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let songName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Do it"
        return label
    }()
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Moloan Luu"
        return label
    }()
    
    private let favoritButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureCell() {
        songImage.image = post
    }
    
}

extension TopTrendingCell {
    private func setupConstraints() {
        addSubview(songImage)
        addSubview(songName)
        addSubview(artistNamelabel)
        addSubview(favoritButton)
        
        songImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(200)
        }
        
        songName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(140)
        }
        
        artistNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(songName.snp.bottom).offset(7)
        }
        
        favoritButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(140)
        }
    }
}
