//
//  extension UIColor.swift
//  nike
//
//  Created by Pasha on 19.01.2025.
//

import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedHex.hasPrefix("#") {
            cleanedHex.removeFirst()
        }
        
        let scanner = Scanner(string: cleanedHex)
        var rgbaValue: UInt64 = 0
        scanner.scanHexInt64(&rgbaValue)
        
        let red = CGFloat((rgbaValue & 0xFF000000) >> 24) / 255.0
        let green = CGFloat((rgbaValue & 0x00FF0000) >> 16) / 255.0
        let blue = CGFloat((rgbaValue & 0x0000FF00) >> 8) / 255.0
        let alpha = CGFloat(rgbaValue & 0x000000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
