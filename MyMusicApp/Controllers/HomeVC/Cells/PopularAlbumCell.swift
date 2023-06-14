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
        return image
    }()
    
    private let buttonExploreNow: UIButton = {
        let button = UIButton()
        button.setTitle("Explore Now", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.white.cgColor
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = false
        button.layer.cornerRadius = 4
        return button
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        //albumImage.image = image
        backgroundColor = .red
        layer.cornerRadius = 15
    }
    
}

extension PopularAlbumCell {
    private func setupConstraints() {
        addSubview(albumImage)
        albumImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(buttonExploreNow)
        buttonExploreNow.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-150)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
