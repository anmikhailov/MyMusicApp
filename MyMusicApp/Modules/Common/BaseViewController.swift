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
    
    func navBarButtonHandler() {
        print(#function)
    }
}

extension BaseViewController {
    func addNavBarButton(with image: UIImage?) {
        let button = UIButton(type: .system)
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .white
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(navBarButtonHandler), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
}
