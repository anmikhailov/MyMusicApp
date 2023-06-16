//
//  NewSongCell.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class NewSongCell: UICollectionViewCell {
    
    let image1 = UIImage(named: "music2")
    
    // MARK: - Properties
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "The Weekend"
        return label
    }()
    
    private let songNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Save Your Tears"
        return label
    }()
    
    private let songImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configure() {
        songImage.image = image1
        backgroundColor = .clear
    }
}

// MARK: - Constraints

extension NewSongCell {
    
    private func setupConstraints() {
        addSubview(songImage)
        addSubview(songNamelabel)
        addSubview(artistNamelabel)
        
        songImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(songNamelabel.snp.top).offset(-10)
            make.width.height.equalTo(150)
        }
        
        songNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalTo(artistNamelabel.snp.top).offset(-5)
        }
        
        artistNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
    
}
