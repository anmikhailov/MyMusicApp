//
//  BaseNavigationController.swift
//  MyMusicApp
//
//  Created by Andrey on 30.06.2023.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .backgroundColor
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: Resources.Fonts.MontserratSemiBold(with: 40)
        ]
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: Resources.Fonts.MontserratSemiBold(with: 25)
        ]
    }
}
