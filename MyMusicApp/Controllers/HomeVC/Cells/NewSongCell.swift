//
//  NewSongCell.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class NewSongCell: UICollectionViewCell {
    
    let image1 = UIImage(named: "music1")
    
    // MARK: - Properties
    
    private let artistNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "The Weekend"
        return label
    }()
    
    private let songNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Save Your Tears"
        return label
    }()
    
    private let songImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        //songImage.image = image1
        backgroundColor = .blue
    }
    
    func setupConstraints() {
        addSubview(songImage)
        addSubview(songNamelabel)
        addSubview(artistNamelabel)
        
        songImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(songNamelabel.snp.top).offset(10)
        }
            
        songNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalTo(artistNamelabel.snp.top).offset(5)
        }
                
        artistNamelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(5)
        }
            
    }
    
}
