//
//  SearchView.swift
//  MyMusicApp
//
//  Created by Andrey on 14.06.2023.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchView(_ view: SearchView, didTapCloseButton button: UIButton)
}

class SearchView: CustomView, UISearchResultsUpdating {
    
    weak var delegate: SearchViewDelegate?
    
    //MARK: - Variables
    private lazy var topHStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.distribution = .fill
        element.spacing = 10
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var searchView: UISearchBar = {
        let element = UISearchBar()
        element.searchBarStyle = .minimal
        element.placeholder = "Search"
        element.backgroundColor = Resources.Colors.neutral1.withAlphaComponent(0.7)
        element.layer.cornerRadius = 10
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var closeWindowButton: UIButton = {
        let element = UIButton()
        element.setTitle("Cancel", for: .normal)
        element.setTitleColor(Resources.Colors.brand1, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return element
    }()
    
//    private lazy var topSegmentControl: CustomSegmentedControl = {
//        let element = CustomSegmentedControl(frame: CGRect(x: 0, y: 100, width: 380, height: 50), buttonTitle: ["All", "Artist", "Album", "Song", "Playlist"])
//        element.selectorViewColor = .white
//        element.selectorTextColor = .white
//        element.backgroundColor = .clear
//        element.translatesAutoresizingMaskIntoConstraints = false
//        return element
//    }()
    
    lazy var searchItemsCollectionView: UICollectionView = {
        let element = UICollectionView()
        
        return element
    }()
    
    lazy var mainTableView: UITableView = {
        let element = UITableView()
        element.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        element.backgroundColor = .clear
        element.separatorStyle = .none
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        self.backgroundColor = Resources.Colors.brand2
        
        self.addSubview(topHStackView)
        
        topHStackView.addArrangedSubview(searchView)
        topHStackView.addArrangedSubview(closeWindowButton)
        
//        self.addSubview(topSegmentControl)
        self.addSubview(mainTableView)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
//            topSegmentControl.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
//            topSegmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
//            topSegmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
//            topSegmentControl.heightAnchor.constraint(equalToConstant: 60),
            
            topHStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            topHStackView.heightAnchor.constraint(equalToConstant: 40),
            topHStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            topHStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            mainTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            mainTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            mainTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            mainTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

//MARK: - Target Actions
private extension SearchView {
    @objc func didTapCloseButton(_ button: UIButton) {
        delegate?.searchView(self, didTapCloseButton: button)
    }
}

