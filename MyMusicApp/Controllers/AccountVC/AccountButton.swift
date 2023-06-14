//
//  AccountButton.swift
//  MyMusicApp
//
//  Created by Admin on 13.06.2023.
//

import UIKit
import SnapKit

class AccountUIButton: UIButton {
    
    let buttonAfteTextImageView = UIImageView()
    let buttonBeforTextImageView = UIImageView()
    let nameBattonLabel = UILabel()
    
    init (labelText: String, imageAfterText: UIImage?, imageBeforeText:UIImage?) {
        super.init(frame: .zero)
        self.nameBattonLabel.text = labelText
        self.nameBattonLabel.textColor = .white
        self.buttonAfteTextImageView.image = imageAfterText
        self.buttonAfteTextImageView.tintColor = .white
        self.buttonBeforTextImageView.image = imageBeforeText
        self.buttonBeforTextImageView.tintColor = .white
        setupViews()
        addSubviewsToButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupButton()
        setupLabel()
    }
    
    private func setupButton() {
        self.backgroundColor = Resources.Colors.TabBarColors.background
        buttonAfteTextImageView.contentMode = .scaleAspectFit
        buttonBeforTextImageView.contentMode = .scaleAspectFit
    }
    
    private func setupLabel() {
        nameBattonLabel.font = UIFont(name: "Roboto-Regular", size: 14)
    }
    
    //MARK: - Layout
    
    private func addSubviewsToButton() {
        let views: [UIView] = [buttonAfteTextImageView, buttonBeforTextImageView, nameBattonLabel]
        views.forEach { self.addSubview($0) }
        makeConstraints()
    }
    
    private func makeConstraints() {
        buttonAfteTextImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.trailing.equalToSuperview().inset(14)
            make.width.equalTo(20)
            make.height.equalTo(12)
        }
        
        buttonBeforTextImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(14)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        nameBattonLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(68)
            make.trailing.equalTo(buttonAfteTextImageView.snp.leading).offset(-8)
            make.width.height.equalTo(24)
        }
    }
}

