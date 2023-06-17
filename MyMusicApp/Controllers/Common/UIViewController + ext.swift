//
//  UIViewController + ext.swift
//  MyMusicApp
//
//  Created by Andrey on 17.06.2023.
//

import UIKit

extension UIViewController {
    func configureNavBar(with title: String, backgroundColor: UIColor, rightButtonImage: UIImage?) {
        let labelItem = UILabel()
        labelItem.textColor = .white
        labelItem.text = title
        labelItem.font = Resources.Fonts.RobotoBold(with: 48)
        labelItem.textAlignment = .center
        
        let button = UIBarButtonItem(image: rightButtonImage,
                                     style: .plain,
                                     target: self,
                                     action: #selector(barButtonTapped))
        button.tintColor = UIColor.white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: labelItem)
        navigationItem.rightBarButtonItem = button
        
        view?.backgroundColor = backgroundColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func barButtonTapped() {
        print("bar Button Tapped")
    }
}
