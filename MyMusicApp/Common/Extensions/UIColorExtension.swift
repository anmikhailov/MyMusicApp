//
//  UIColorExtension.swift
//  MyMusicApp
//
//  Created by Andrey on 11.06.2023.
//

import UIKit

//MARK: - init HEX
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
   }

  convenience init(hex: Int, alpha: CGFloat = 1) {
      let r = CGFloat((hex & 0xff0000) >> 16) / 255
      let g = CGFloat((hex & 0x00ff00) >> 8) / 255
      let b = CGFloat(hex & 0x0000ff) / 255
      self.init(red: r, green: g, blue: b, alpha: alpha)
  }
}

//MARK: - Custom colors
extension UIColor {
    class var backgroundColor: UIColor {
        return UIColor(hex: 0x0E0B1F)
    }
    
    class var brandGreen: UIColor {
        return UIColor(hex: 0xCBFB5E)
    }
    
    class var brandBlack: UIColor {
        return UIColor(hex: 0x0E0B1F)
    }
    
    class var neutral1: UIColor {
        return UIColor(hex: 0xEEEEEE)
    }
    
    class var neutral2: UIColor {
        return UIColor(hex: 0x7A7C81)
    }
    
    class var neutral3: UIColor {
        return UIColor(hex: 0x20242F)
    }
}
