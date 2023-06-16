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
    
    var exploreCollectionView: ExploreCollectionView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupConstraints()
        

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
        
        view.addSubview(exploreCollectionView)
        
        exploreCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
}
