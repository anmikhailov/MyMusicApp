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
    
    var exploreCollectionView: ExploreCollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupConstraints()
        configureNavBar(with: "Explore", backgroundColor: .clear, rightButtonImage: Resources.Icons.Common.search)
        
    }
    
    // MARK: - Private methods
    
    private func setupCollectionView() {
        let sectionRecentlyMusic = ExploreSection(title: "Recently Music", items: [""], style: .recentlyMusic)
        let sectionTopTrending = ExploreSection(title: "Top Trending", items: [""], style: .topTrending)
        let sectionTopic = ExploreSection(title: "Topic", items: [""], style: .topic)
        
        let sectionsE = [sectionRecentlyMusic, sectionTopTrending, sectionTopic]
        
        exploreCollectionView = ExploreCollectionView(frame: view.bounds)
        exploreCollectionView.setSections(sectionsE)
        
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
        
        view.addSubview(exploreCollectionView)
        
        exploreCollectionView.snp.makeConstraints { make in
            make.top.equalTo(helperView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
}
