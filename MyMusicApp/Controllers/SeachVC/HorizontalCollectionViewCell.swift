//
//  HorizontalCollectionViewCell.swift
//  MyMusicApp
//
//  Created by Andrey on 15.06.2023.
//

import Foundation
import UIKit

class HorizontalCollectionViewCell: UICollectionViewCell {
    
    static let menuFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.neutral2
        label.textAlignment = .center
        label.font = menuFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bottomSeparator: UIImageView = {
        let element = UIImageView()
        element.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        element.backgroundColor = .white
        element.isHidden = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = self.isSelected ? UIFont.systemFont(ofSize: 24, weight: .bold) : UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabel.textColor = self.isSelected ? .white : Resources.Colors.neutral2
            
            bottomSeparator.isHidden = !self.isSelected
        }
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setupViews() {
        backgroundColor = .none
        
        addSubview(titleLabel)
        addSubview(bottomSeparator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparator.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomSeparator.widthAnchor.constraint(equalToConstant: frame.width),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 4),
        ])
    }
}
