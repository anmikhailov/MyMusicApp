//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 14.06.2023.
//

import UIKit

class SearchViewController: CustomViewController<SearchView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
    }
}

//MARK: - SearchViewDelegate
extension SearchViewController: SearchViewDelegate {
    func searchView(_ view: SearchView, didTapButton button: UIButton) {
    }
}
