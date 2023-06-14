//
//  AccountButton.swift
//  MyMusicApp
//
//  Created by Admin on 13.06.2023.
//

import UIKit
import SnapKit

class AccountUIButton: UIButton {
    
    let buttonImageView = UIImageView()
    let nameBattonLabel = UILabel()
    
    init (labelText: String, image: UIImage?) {
        super.init(frame: .zero)
        self.nameBattonLabel.text = labelText
        self.nameBattonLabel.textColor = .white
        self.buttonImageView.image = image
        self.buttonImageView.tintColor = .white
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
        self.layer.cornerRadius = 12
        self.backgroundColor = Resources.Colors.TabBarColors.background
        buttonImageView.contentMode = .scaleAspectFit
    }
    
    private func setupLabel() {
        nameBattonLabel.font = UIFont(name: "Roboto-Regular", size: 14)
    }
    
    //MARK: - Layout
    
    private func addSubviewsToButton() {
        let views: [UIView] = [buttonImageView, nameBattonLabel]
        views.forEach { self.addSubview($0) }
        makeConstraints()
    }
    
    private func makeConstraints() {
        buttonImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.trailing.equalToSuperview().inset(14)
            make.width.equalTo(20)
            make.height.equalTo(12)
        }
        nameBattonLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(buttonImageView.snp.leading).offset(-8)
            make.width.height.equalTo(24)
        }
    }
}

