//
//  UIColor+Additions.swift
//  MyHome
//
//  Created by Tin Blanc on 7/6/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

extension UIColor {
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 85.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blueA: UIColor {
        return UIColor(hexString: "56A0E5")
    }
    
    @nonobjc class var pinkA: UIColor {
        return UIColor(hexString: "ED6E85")
    }
}

extension UIColor {
//    static var globalTint: UIColor {
//        return UIColor(hex: 0x183175)
//    }
}

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255
        let g = CGFloat((hex & 0x00ff00) >> 8) / 255
        let b = CGFloat((hex & 0x0000ff)) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat(red) / 255
        let g = CGFloat(green) / 255
        let b = CGFloat(blue) / 255
        
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
    
    convenience init(white: Int, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(white) / 255.0, alpha: alpha)
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue:      CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
