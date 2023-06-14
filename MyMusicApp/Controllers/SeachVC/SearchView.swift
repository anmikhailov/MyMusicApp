//
//  SearchView.swift
//  MyMusicApp
//
//  Created by Andrey on 14.06.2023.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func searchView(_ view: SearchView, didTapButton button: UIButton)
}

class SearchView: CustomView {
    weak var delegate: SearchViewDelegate?
    
    //MARK: - Variables
    // Add private lazy variables here
    
    //MARK: - setViews
    override func setViews() {
        super.setViews()
        
        // Add subviews here
    }
    
    //MARK: - layoutViews
    override func layoutViews() {
        super.layoutViews()
        
        // Add constraints here
    }
}

//MARK: - Target Actions
private extension SearchView {
    @objc func didTapButton(_ button: UIButton) {
        delegate?.searchView(self, didTapButton: button)
    }
}

