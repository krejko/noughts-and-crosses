//
//  Game.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/4/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func didFinishTurn(cellLocation: CellLocation, piece: GamePiece)
}


enum PlayerType {
    case human, computer
}



class Game: NSObject {
    
    
    private let players: [(type: PlayerType, piece: GamePiece)]
    private lazy var currentPlayerIndex = 0
    private lazy var boardLayout: [(cellLocation: CellLocation, piece: GamePiece)] = []
    
    weak var delegate:GameDelegate?
    
    
    init(firstPlayerType: PlayerType = PlayerType.human,
         firstPlayerPiece: GamePiece = GamePiece.x,
         secondPlayerType: PlayerType = PlayerType.computer) {
        let secondPlayerPiece = (firstPlayerPiece == GamePiece.x) ? GamePiece.o : GamePiece.x
        players = [(firstPlayerType, firstPlayerPiece),
                   (secondPlayerType, secondPlayerPiece)]
    }
    
    func takeNextTurn(playerIndex: Int, selectedCellLocation: CellLocation) {
        if playerIndex != currentPlayerIndex { // ensure play is in order
            return
        }
        
        let success = recordSelectedCellLocation(selectedCellLocation: selectedCellLocation)
        
        if success {  // ensure valid, non-occupied location
            delegate?.didFinishTurn(cellLocation: selectedCellLocation, piece: currentPlayer().piece)
            checkEndGameCondition()
            endTurn()
            
            if currentPlayer().type == PlayerType.computer {
                triggerComputerTurn()
            }
        }
    }
    
    func recordSelectedCellLocation(selectedCellLocation: CellLocation) -> Bool {
        if occupiedLocations().contains(selectedCellLocation){
            return false
        }
        
        boardLayout.append((cellLocation: selectedCellLocation, currentPlayer().piece))
        return true
    }
    
    func checkEndGameCondition () {
        if availableLocations().count > 0 {  // Draw
            
        }
            
    }
    
    func endTurn () {
        currentPlayerIndex = (currentPlayerIndex == 0) ? 1 : 0
    }
    
    func triggerComputerTurn() {
        if availableLocations().count > 0 {
            let location = randomAvailableLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(0.5)) {
                self.takeNextTurn(playerIndex: self.currentPlayerIndex,
                                  selectedCellLocation: location)
            }
        }
    }
    
    // MARK - Helper Functions
    
    func currentPlayer () -> (type: PlayerType, piece: GamePiece) {
        return players[currentPlayerIndex]
    }
    
    func occupiedLocations () -> Array<CellLocation> {
        return boardLayout.map { $0.cellLocation }
    }
    
    func availableLocations () -> Array<CellLocation> {
        return CellLocation.all().filter { !occupiedLocations().contains($0) }
    }
    
    func randomAvailableLocation() -> CellLocation {
        let locations = availableLocations()
        let randomIndex = Int(arc4random_uniform(UInt32(locations.count)))
        return locations[randomIndex]
    }
    
    func locationsForPiece (piece: GamePiece) -> Array<CellLocation> {
        return boardLayout.filter{$0.piece == piece}.map{$0.cellLocation}
    }
    
}
