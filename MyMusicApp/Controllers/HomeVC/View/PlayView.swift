//
//  PlayView.swift
//  MyMusicApp
//
//  Created by mac on 6/21/23.
//

import UIKit
import SnapKit


class PlayView: UIView {
    
    // MARK: - Properties
    var isPlay = true {
        didSet {
            if isPlay {
                playButton.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
                songNameLabel.text = "Playing now"
            } else {
                playButton.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
                songNameLabel.text = "Paused"
            }
        }
    }

    lazy var previousButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "backward.end"), for: .normal)
            button.tintColor = .black
            return button
        }()
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Playing now"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        
        return label
    }()

    let groupNameLabel: UILabel = {
        let label = UILabel()
        label.text = "One Republic"
        label.textAlignment = .center
        label.textColor = UIColor(red: 238, green: 238, blue: 238)
        label.font = UIFont(name: "Roboto-Regular", size: 18)
        
        return label
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "forward.end"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pause.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .none
        imageView.image = UIImage(named: "gangz")
        return imageView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setupButton() {
        playButton.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
    }
    
    @objc private func playButtonTapped() {
        isPlay.toggle()
        PlaybackManager.shared.playPausePlayback()
    }
    
}

//MARK: - Setup Constraints
extension PlayView {
    func setupConstraints() {
        self.backgroundColor = .green
        addSubview(songNameLabel)
        addSubview(groupNameLabel)
        addSubview(albumImageView)
        addSubview(nextButton)
        addSubview(previousButton)
        addSubview(playButton)
        
        albumImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        songNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(albumImageView.snp.trailing).offset(30)
            make.centerY.equalToSuperview()
        }
        
        previousButton.snp.makeConstraints { make in
            make.trailing.equalTo(playButton.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(nextButton.snp.leading).offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(35)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
            make.width.height.equalTo(35)
        }
    }
}
