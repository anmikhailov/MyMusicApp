//
//  ExploreViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

protocol SeeAllProtocol: AnyObject {
    func goToSeeAll()
}

class ExploreViewController: UIViewController {
    
    // MARK: - Properties
    private let helperView = UIView()
    
    private var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collection.backgroundColor = nil
        collection.bounces = true
        return collection
    }()
    
    lazy var sections: [ExploreSection] = [.recentlyMusic, .topTrending, .topic]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Resources.Colors.TabBarColors.background
        
        setupCollectionView()
        setupConstraints()
        configureNavBar(with: "Explore", backgroundColor: .clear, rightButtonImage: Resources.Icons.Common.search)
        
    }
    
    // MARK: - Private methods
    
    private func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        setupCells()
        collectionView.collectionViewLayout = createCompositionLayout()
        
    }
    
    private func setupCells() {
        collectionView.register(RecentlyMusicCell.self, forCellWithReuseIdentifier: "cell3")
        collectionView.register(TopTrendingCell.self, forCellWithReuseIdentifier: "cell4")
        collectionView.register(TopicCell.self, forCellWithReuseIdentifier: "cell5")
        
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(ExploreCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ExploreCollectionReusableView.identifier)
    }
    
}

extension ExploreViewController {
    
    func setupConstraints() {
        
        view.addSubview(helperView)
        helperView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            helperView.topAnchor.constraint(equalTo: view.topAnchor),
            helperView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            helperView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            helperView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

