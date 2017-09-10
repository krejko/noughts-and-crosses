//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by Kevin Rejko on 8/31/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import XCTest
@testable import TicTacToe

class GameTests: XCTestCase {
    
    var ticTacToeGame: Game!

    override func setUp() {
        super.setUp()
        ticTacToeGame = Game()
    }
    
    override func tearDown() {
        ticTacToeGame = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
