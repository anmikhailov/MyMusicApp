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
        enum TabBarColors{
            static var active = UIColor(hex: 0xCBFB5E)
            static var inactive = UIColor(hex: 0x71737B)
            static var background = UIColor(hex: 0x0E0B1F)
        }
        
        static var brand1 = UIColor(hex: 0xCBFB5E)
        static var brand2 = UIColor(hex: 0x0E0B1F)
        static var neutral1 = UIColor(hex: 0xEEEEEE)
        static var neutral2 = UIColor(hex: 0x7A7C81)
        static var neutral3 = UIColor(hex: 0x20242F)
    }
    
    enum Icons {
        enum TabBar {
            static var home = UIImage(named: "home.svg")
            static var explore = UIImage(named: "pin.svg")
            static var favorites = UIImage(named: "favorite.svg")
            static var account = UIImage(named: "user.svg")
        }
    }
    
    enum Strings {
        enum TabBar {
            static var home = "Home"
            static var explore = "Explore"
            static var favorites = "Favorites"
            static var account = "Account"
        }
    }
    
    enum Fonts {
        static func MontserratMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Medium", size: size) ?? UIFont() }
        static func MontserratRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Regular", size: size) ?? UIFont() }
        static func RobotoBlack(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Black", size: size) ?? UIFont() }
        static func RobotoMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Mediuam", size: size) ?? UIFont() }
        static func RobotoRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Regular", size: size) ?? UIFont() }
        static func RobotoBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Roboto-Bold", size: size) ?? UIFont() }
    }
}
