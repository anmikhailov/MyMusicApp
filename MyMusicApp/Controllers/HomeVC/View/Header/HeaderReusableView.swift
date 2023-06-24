//
//  HeaderReusableView.swift
//  MyMusicApp
//
//  Created by mac on 6/14/23.
//

import UIKit
import SnapKit

class HeaderReusableView: UICollectionReusableView {
        
    // MARK: - Properties
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
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
    
    func configure(title: String) {
        headerLabel.text = title
    }
}

// MARK: - Constraints

extension HeaderReusableView {
   private func setupConstraints() {
        addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-5)
//            make.trailing.equalToSuperview().offset(-50)
        }
    }
}
