//
//  Resources.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import Foundation
import UIKit

enum Resources {
    enum Colors {
        enum TabBarColors {
            static var active = UIColor.brandGreen
            static var inactive = UIColor.neutral1
        }
    }
    
    enum Icons {
        enum TabBar {
            static var home = UIImage(named: "home.svg")
            static var explore = UIImage(named: "pin.svg")
            static var favorites = UIImage(named: "favorite.svg")
            static var account = UIImage(named: "user.svg")
        }
        
        enum NavBar {
            static var search = UIImage(systemName: "magnifyingglass")
            static var accountSettings = UIImage(systemName: "gearshape")
        }
    }
    
    enum Strings {
        enum TabBar {
            static var home = "Home"
            static var explore = "Explore"
            static var favorites = "Favorites"
            static var account = "Account"
        }
        
        enum NavBar {
            static var home = "Music"
            static var explore = "Explore"
            static var favorites = "Favorites"
            static var account = "Account"
        }
    }
    
    enum Fonts {
        static func MontserratMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Medium", size: size) ?? UIFont() }
        static func MontserratSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont() }
        static func MontserratRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Regular", size: size) ?? UIFont() }
        static func RobotoBlack(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Black", size: size) ?? UIFont() }
        static func RobotoMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Medium", size: size) ?? UIFont() }
        static func RobotoRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Regular", size: size) ?? UIFont() }
        static func RobotoBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Bold", size: size) ?? UIFont() }
    }
}
