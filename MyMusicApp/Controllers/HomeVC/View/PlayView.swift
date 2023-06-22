//
//  PlayView.swift
//  MyMusicApp
//
//  Created by mac on 6/21/23.
//

import UIKit
import SnapKit

class PlayView: UIView {

    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Come to me"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Roboto-Bold", size: 36)
        
        return label
    }()
    // MARK: - groupNameLabel
    let groupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "One Republic"
        label.textAlignment = .center
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        
        return label
    }()
    
    var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        
        return button
    }()
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension PlayView {
    func setupConstraints() {
        addSubview(songNameLabel)
        addSubview(groupNameLabel)
        addSubview(albumImageView)
        addSubview(nextButton)
        addSubview(backButton)
        addSubview(playButton)
        
        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalTo(songNameLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.equalTo(songNameLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
            make.width.height.equalTo(24)
        }
    }
}
