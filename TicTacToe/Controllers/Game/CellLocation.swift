//
//  CellLocation.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/4/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import Foundation

enum CellLocation: Int {
    case topLeft,
    topCenter,
    topRight,
    middleLeft,
    middleCenter,
    middleRight,
    bottomLeft,
    bottomCenter,
    bottomRight
    
    private static let _count: CellLocation.RawValue = {
        // find the maximum enum value
        var maxValue: Int = 0
        while let _ = CellLocation(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func random() -> CellLocation {
        // pick and return a new value
        let rand = Int(arc4random_uniform(UInt32(_count)))
        return CellLocation(rawValue: rand)!
    }
}
