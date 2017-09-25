//
//  UIColor+Hex.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/10/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(rgbHex: Int) {
        self.init(red:UIColor.colorDecimalFromShiftedHex(hex: rgbHex, bitsToShift: 16),
                  green:UIColor.colorDecimalFromShiftedHex(hex: rgbHex, bitsToShift: 8),
                  blue:UIColor.colorDecimalFromShiftedHex(hex: rgbHex, bitsToShift: 0),
                  alpha: 1.0)
    }
    
    convenience init(argbHex:Int) {
        self.init(red:UIColor.colorDecimalFromShiftedHex(hex: argbHex, bitsToShift: 16),
                  green:UIColor.colorDecimalFromShiftedHex(hex: argbHex, bitsToShift: 8),
                  blue:UIColor.colorDecimalFromShiftedHex(hex: argbHex, bitsToShift: 0),
                  alpha: UIColor.colorDecimalFromShiftedHex(hex: argbHex, bitsToShift: 24) )
    }
    
    class func colorDecimalFromShiftedHex(hex: Int, bitsToShift: Int) -> CGFloat {
        return CGFloat((hex >> bitsToShift) & 0xff) / 255.0
    }
}
