//
//  TrackListReusableView.swift
//  MyMusicApp
//
//  Created by mac on 6/24/23.
//

import UIKit

class TrackListReusableView: UICollectionReusableView {
        
    // MARK: - Properties
    
    var delegate: TrackListProtocol?
    private var section: Int = 0

        
    static var identifier = "HeaderList"
    
    private let headerLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textColor = .white
            return label
        }()
    
    lazy var seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("View All", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
        return button
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
    
    @objc func seeAllTapped() {
        delegate?.goToSeeAllMusic()
    }
    
    func configure(title: String,delegate: ExploreViewController) {
        headerLabel.text = title
        self.delegate = delegate
    }
    
}

extension TrackListReusableView {
    private func setupConstraints() {
        addSubview(seeAllButton)
        addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-5)
           
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        
    }
}

