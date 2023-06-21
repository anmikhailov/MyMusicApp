//
//  RecentlyMusicCell.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class RecentlyMusicCell: UICollectionViewCell {
    
    var imageRecently = UIImage(named: "music3")
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Properties
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        //label.text = "Taylor Swift"
        return label
    }()
    
    private let songNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        //label.text = "Love Story"
        return label
    }()
    
    private let songImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        layer.masksToBounds = true
        setupConstraints()
        loadingActivityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(recentlyMusic: PlayHistoryObject) {
        songNamelabel.text = recentlyMusic.track.name
        artistNamelabel.text = recentlyMusic.track.artists.first?.name
        
    }
    
    func setupImage(imageAlbum: SpotifyImage) {
        guard let urlToImage = imageAlbum.url else {
            songImage.image = imageRecently
            songImage.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }
        
        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: imageRecently) { [weak self] image in
                guard let self = self else { return }
                
                guard let image else {
                    self.songImage.image = image
                    self.songImage.contentMode = .scaleAspectFill
                    self.loadingActivityIndicator.stopAnimating()
                    return
                }
                
                self.songImage.image = image
                self.songImage.contentMode = .scaleAspectFill
                self.loadingActivityIndicator.stopAnimating()
            }
    }
    
}

// MARK: - Constraints

extension RecentlyMusicCell {
    private func setupConstraints() {
        
        addSubview(songImage)
        songImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.height.equalTo(60)
        }
        
        addSubview(songNamelabel)
        songNamelabel.snp.makeConstraints { make in
            make.leading.equalTo(songImage.snp.trailing).offset(8)
            make.top.equalToSuperview().offset(10)
        }
        
        addSubview(artistNamelabel)
        artistNamelabel.snp.makeConstraints { make in
            make.leading.equalTo(songImage.snp.trailing).offset(8)
            make.top.equalTo(songNamelabel.snp.bottom).offset(10)
        }
        
        addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        addSubview(loadingActivityIndicator)
        loadingActivityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        
    }
}
