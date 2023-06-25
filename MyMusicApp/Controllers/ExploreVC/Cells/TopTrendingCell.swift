//
//  TopTrendingCell.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import UIKit
import SnapKit

class TopTrendingCell: UICollectionViewCell {
    
    //let post = UIImage(named: "top")
    
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
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
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
    
    func configureCell(title: String, name: String, image: UIImage) {
        songImage.image = image
        songName.text = title
        artistNamelabel.text = name
    }
    
//    func setupImage(imageAlbum: SpotifyImage) {
//        guard let urlToImage = imageAlbum.url else {
//            songImage.image = post
//            songImage.contentMode = .scaleAspectFill
//            //loadingActivityIndicator.stopAnimating()
//            return
//        }
//
//        ImageClient.shared.setImage(
//            from: urlToImage,
//            placeholderImage: post) { [weak self] image in
//                guard let self = self else { return }
//
//                guard let image else {
//                    self.songImage.image = image
//                    self.songImage.contentMode = .scaleAspectFill
//                   // self.loadingActivityIndicator.stopAnimating()
//                    return
//                }
//
//                self.songImage.image = image
//                self.songImage.contentMode = .scaleAspectFill
//                //self.loadingActivityIndicator.stopAnimating()
//            }
//    }
//    
    
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
            make.trailing.equalToSuperview().offset(-100)
            make.top.equalToSuperview().offset(120)
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
