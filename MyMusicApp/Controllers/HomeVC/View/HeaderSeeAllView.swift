//
//  HeaderSeeAllView.swift
//  MyMusicApp
//
//  Created by mac on 6/15/23.
//

import UIKit
import SnapKit

class HeaderSeeAllView: UICollectionReusableView {
    
    // MARK: - Properties
    
    var delegate: GoToSeeAllProtocol?
        
    static var identifier = "headerSeeAll"
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    @objc func seeAllTapped() {
        delegate?.goToSeeAll()
    }
    
    private func configure(delegate: UIViewController) {
        self.delegate = delegate as? GoToSeeAllProtocol
    }
    
}

extension HeaderSeeAllView {
    private func setupConstraints() {
        addSubview(seeAllButton)
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.centerY.equalToSuperview()
        }
    }
}
