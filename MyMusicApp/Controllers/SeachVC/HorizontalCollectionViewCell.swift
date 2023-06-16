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
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = self.isSelected ? UIFont.systemFont(ofSize: 24, weight: .bold) : UIFont.systemFont(ofSize: 18, weight: .bold)
            titleLabel.textColor = self.isSelected ? .white : Resources.Colors.neutral2
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
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
