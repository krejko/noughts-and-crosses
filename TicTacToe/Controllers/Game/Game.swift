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
    
    func takeNextTurn(selectedCellLocation: CellLocation) {
        var location = selectedCellLocation
        
        if currentPlayer().type == PlayerType.computer {
            
            //TODO check for valid next
            location = CellLocation.random()
        }
        
        let success = recordSelectedCellLocation(selectedCellLocation: location)

        if !success {
            
        }else {
            delegate?.didFinishTurn(cellLocation: selectedCellLocation, piece: currentPlayer().piece)
        }
        
        // check for win condition

        //

        
    }
    
    func recordSelectedCellLocation(selectedCellLocation: CellLocation) -> Bool {
        if occupiedLocations().contains(selectedCellLocation){
            print("Cell Occupied: \(String(describing: selectedCellLocation))" )
            return false
        }
        
        // add the selected location for the player
        boardLayout.append((cellLocation: selectedCellLocation, currentPlayer().piece))
        
        return true
    }
    
    // MARK - Helper Functions
    
    func currentPlayer () -> (type: PlayerType, piece: GamePiece) {
        return players[currentPlayerIndex]
    }
    
    func occupiedLocations () -> Array<CellLocation> {
        return boardLayout.map { $0.cellLocation }
    }
    
}
