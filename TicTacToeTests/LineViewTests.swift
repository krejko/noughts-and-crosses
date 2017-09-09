//
//  LineViewTests.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/9/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

@testable import TicTacToe
import XCTest

class LineViewTests: XCTestCase {
    
    var lineView: LineView!
    
    override func setUp() {
        super.setUp()
        lineView = LineView()
    }
    
    override func tearDown() {
        lineView = nil
        super.tearDown()
    }
    
    func testCalculateDrawingIncrementPercentWithInvalidDuration() {
        let percent = lineView.calculateDrawingIncrementPercent(withDuration: -1.0)
        XCTAssertEqual(percent, 1.0, "Percent generated from calculating increment is wrong")
    }

    func testCalculateDrawingIncrementPercentWithTenTimesDuration() {
        let percent = lineView.calculateDrawingIncrementPercent(withDuration: 0.5, frequency: 0.05)
        XCTAssertEqual(percent, 0.1, "Percent generated from calculating increment is wrong")
    }
    
}
