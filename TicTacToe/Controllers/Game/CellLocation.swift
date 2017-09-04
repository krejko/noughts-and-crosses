//
//  Location.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/4/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import Foundation

enum Location: Int {
    case topLeft,
    topCenter,
    topRight,
    middleLeft,
    middleCenter,
    middleRight,
    bottomLeft,
    bottomCenter,
    bottomRight
    
    static func all() -> Array <Location> {
        var locations : Array <Location> = []
        for location in iterateEnum(self) {
            locations.append(location)
        }
        return locations
    }
    
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
        
}

