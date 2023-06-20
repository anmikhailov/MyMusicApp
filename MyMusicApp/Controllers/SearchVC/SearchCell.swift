//
//  SearchCell.swift
//  MyMusicApp
//
//  Created by Andrey on 15.06.2023.
//

import UIKit

protocol SearchCellDelegate: AnyObject {
    func moreActionsButtonTapped(_ cell: SearchCell)
}

class SearchCell: UITableViewCell {
    
    weak var delegate: SearchCellDelegate?
    static let identifier = "SearchCell"
    
    // MARK: - UI Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
       let label = UILabel()
        label.text = ""
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var albumImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.image = UIImage(named: "AppIcon")
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var moreActionsButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(buttonMoreActionIsPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomSeparator: UIImageView = {
        let element = UIImageView()
        element.frame = CGRect(x: 0, y: 0, width: 1, height: 1)
        element.backgroundColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setViews
    func setViews() {
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(albumImageView)
        contentView.addSubview(moreActionsButton)
        contentView.addSubview(bottomSeparator)
    }
    
    //MARK: - layoutViews
    func layoutViews() {
        NSLayoutConstraint.activate([
            albumImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            albumImageView.heightAnchor.constraint(equalToConstant: 43),
            albumImageView.widthAnchor.constraint(equalToConstant: 43),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: moreActionsButton.leadingAnchor, constant: -10),
            
            subTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            subTitleLabel.leadingAnchor.constraint(equalTo: albumImageView.trailingAnchor, constant: 15),
            subTitleLabel.trailingAnchor.constraint(equalTo: moreActionsButton.leadingAnchor, constant: -10),
            
            moreActionsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            moreActionsButton.widthAnchor.constraint(equalToConstant: 20),
            moreActionsButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1),
            bottomSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    @objc private func buttonMoreActionIsPressed(_ sender: UIButton) {
        delegate?.moreActionsButtonTapped(self)
    }
    
}
