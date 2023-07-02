//
//  ExploreViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

class ExploreViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Strings.NavBar.explore
        
        addNavBarButton(with: Resources.Icons.NavBar.search)
    }
    
    override func navBarButtonHandler() {
        print("Nav bar tapped. Handler from ExploreViewController")
    }
}
