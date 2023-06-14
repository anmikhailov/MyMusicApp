//
//  RecentlyMusicCell.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class RecentlyMusicCell: UICollectionViewCell {
    
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
        backgroundColor = .green
    }
    
}

extension RecentlyMusicCell {
    private func setupConstraints() {
        
        addSubview(songImage)
        songImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(32)
        }
        
        
        
    }
}
