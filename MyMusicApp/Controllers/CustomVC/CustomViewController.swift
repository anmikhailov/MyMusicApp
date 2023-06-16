//
//  CustomViewController.swift
//  MyMusicApp
//
//  Created by Andrey on 12.06.2023.
//

import UIKit

class CustomViewController<V: CustomView>: UIViewController {
    override func loadView() {
        view = V()
    }
    
    var customView: V {
        return view as! V
    }
}
