//
//  TopicCell.swift
//  MyMusicApp
//
//  Created by mac on 6/16/23.
//

import UIKit

class TopicCell: UICollectionViewCell {
    
    let imageCategory = UIImage(named: "hip-hop")
    
    
    // MARK: - Properties
    
    let categoryImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let image2: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 3
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let categoryName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Hip - Hop"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureCell(image: UIImage, title: String) {
        categoryImage.image = image
        categoryName.text = title
    }
    
    
}

extension TopicCell {
    private func setupConstraints() {
        addSubview(categoryImage)
        addSubview(image2)
        addSubview(categoryName)
        
        categoryName.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        image2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categoryImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
    }
}
