//
//  BaseViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

@objc
extension BaseViewController {
    private func addSubviews() {}
    private func layoutViews(){}
    private func configure() {
        view.backgroundColor = .backgroundColor
    }
}
