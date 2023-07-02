//
//  AccountViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

class AccountViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Resources.Strings.NavBar.account
        
        addNavBarButton(with: Resources.Icons.NavBar.accountSettings)
    }
    
    override func navBarButtonHandler() {
        print("Nav bar tapped. Handler from AccountViewController")
    }
    
}