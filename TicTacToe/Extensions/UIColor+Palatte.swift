//
//  UIColor+Palatte.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/25/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit

extension UIColor {

    struct Palatte{
        static let White = UIColor.init(hex: 0xF2F2F4)
        static let DarkGreen = UIColor.init(hex: 0x657E74)
        static let LightGreen = UIColor.init(hex: 0x93ADA3)
        static let DarkGray = UIColor.init(hex: 0x666666)
    }
    
    class Theme: NSObject {
        
        var backgroundColor: UIColor!
        var primaryColor: UIColor!
        var secondaryColor: UIColor!
        var accentColor: UIColor!
        
        
        class func lightTheme() -> Theme{
            let theme = Theme()
            theme.backgroundColor = UIColor.Palatte.White
            theme.primaryColor = UIColor.Palatte.DarkGreen
            theme.secondaryColor = UIColor.Palatte.LightGreen
            theme.accentColor = UIColor.Palatte.DarkGray
            return theme
        }
    }
}
