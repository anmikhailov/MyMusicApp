//
//  AccountViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit
import SnapKit

class AccountViewController: UIViewController {
    
    var accountLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        SetBacgroundColors()

    }
    
    func SetBacgroundColors(){
        view.backgroundColor = Resources.Colors.TabBarColors.background
    }
    
    func setProfileLabel(){
        accountLabel.text = "Account"
        
    }
    
}


#if DEBUG

import SwiftUI

struct AccountViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = AccountViewController

    func makeUIViewController(context: Context) -> UIViewControllerType {
        AccountViewController(nibName: nil, bundle: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

struct AccountViewController_Previews: PreviewProvider {
    static var previews: some View {
        AccountViewControllerRepresentable()
    }
}

#endif
