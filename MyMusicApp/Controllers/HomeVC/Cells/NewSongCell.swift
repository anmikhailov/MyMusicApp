//
//  NewSongCell.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class NewSongCell: UICollectionViewCell {

    let image1 = UIImage(named: "AppIcon")
    private var loadingActivityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Properties
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
       // label.text = "The Weekend"
        return label
    }()
    
    private let songNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        //label.text = "Save Your Tears"
        return label
    }()
    
    private let songImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
       // loadingActivityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure(newAlbum: NewAlbum) {
        backgroundColor = .clear
        songNamelabel.text = newAlbum.name
        artistNamelabel.text = newAlbum.artists?.first?.name
       
    }
    
    func setupImage(imageAlbum: SpotifyImage) {
        guard let urlToImage = imageAlbum.url else {
            songImage.image = image1
            songImage.contentMode = .scaleAspectFill
            loadingActivityIndicator.stopAnimating()
            return
        }

        ImageClient.shared.setImage(
            from: urlToImage,
            placeholderImage: image1) { [weak self] image in
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

extension NewSongCell {
    
    private func setupConstraints() {
        addSubview(songImage)
        addSubview(songNamelabel)
        addSubview(artistNamelabel)
        addSubview(loadingActivityIndicator)
        
        songImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(songNamelabel.snp.top).offset(-10)
            make.width.height.equalTo(150)
        }
        
        songNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalTo(artistNamelabel.snp.top).offset(-5)
        }
        
        artistNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        loadingActivityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
    }
    
}
