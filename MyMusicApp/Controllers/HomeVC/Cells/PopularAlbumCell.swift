//
//  PopularAlbumCell.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class PopularAlbumCell: UICollectionViewCell {
    
    let image = UIImage(named: "album1")
    
    // MARK: - Properties
    
    private let albumImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.clipsToBounds = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let buttonExploreNow: UIButton = {
        let button = UIButton()
        button.setTitle("Explore Now", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = false
        button.layer.cornerRadius = 4
        return button
    }()
    
    // MARK: - init
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureCell() {
        albumImage.image = image
        layer.cornerRadius = 15
    }
    
}

// MARK: - constraints

extension PopularAlbumCell {
    private func setupConstraints() {
        addSubview(albumImage)
        albumImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(195)
        }
        
        addSubview(buttonExploreNow)
        buttonExploreNow.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(138)
            make.height.equalTo(24)
        }
    }
}
