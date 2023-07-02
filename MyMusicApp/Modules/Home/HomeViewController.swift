//
//  HomeViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

class HomeViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Strings.NavBar.home
        navigationController?.tabBarItem.title = Resources.Strings.TabBar.home
    }
}
