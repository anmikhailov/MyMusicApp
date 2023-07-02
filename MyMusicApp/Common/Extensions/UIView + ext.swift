//
//  UIView + ext.swift
//  MyMusicApp
//
//  Created by Andrey on 02.07.2023.
//

import UIKit

extension UIView {
    
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
