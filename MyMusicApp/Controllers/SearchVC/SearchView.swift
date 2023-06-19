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
        element.backgroundColor = UIColor(hex: 0x292D39, alpha: 1)
        if let textField = element.value(forKey: "searchField") as? UITextField {
            textField.tintColor = UIColor.white
        }
        element.layer.cornerRadius = 10
        element.layer.borderColor = UIColor(hex: 0x363942, alpha: 1).cgColor
        element.layer.borderWidth = 1
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var closeWindowButton: UIButton = {
        let element = UIButton()
        element.setTitle("Cancel", for: .normal)
        element.setTitleColor(Resources.Colors.brand1, for: .normal)
        element.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
        return element
    }()
    
    lazy var searchItemsCollectionView: HorizontalMenuCollectionView = {
        let element = HorizontalMenuCollectionView()
        element.translatesAutoresizingMaskIntoConstraints = false
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
        
        self.addSubview(searchItemsCollectionView)
        self.addSubview(mainTableView)
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        NSLayoutConstraint.activate([
            topHStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            topHStackView.heightAnchor.constraint(equalToConstant: 40),
            topHStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            topHStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            
            searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 300),
            
            searchItemsCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            searchItemsCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            searchItemsCollectionView.topAnchor.constraint(equalTo: topHStackView.bottomAnchor, constant: 20),
            searchItemsCollectionView.heightAnchor.constraint(equalToConstant: 45),
            
            mainTableView.topAnchor.constraint(equalTo: searchItemsCollectionView.bottomAnchor, constant: 15),
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

