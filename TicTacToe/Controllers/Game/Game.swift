//
//  Game.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/4/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import Foundation

protocol GameDelegate: class {
    func didRecordMove(location: Location, piece: GamePiece)
    func didEndTurn()
    func didWinGame(player: (type: PlayerType, piece: GamePiece),
                    winConditions: Array<WinCondition>)
    func didEndGameWithDraw ()
}

enum PlayerType {
    case human, computer
}

enum WinCondition {
    case leftDiagonal,
    rightDiagonal, 
    horizontalTop,
    horizontalMiddle,
    horizontalBottom,
    verticalLeft,
    verticalCenter,
    verticalRight
}

class Game: NSObject {
    
    
    private let players: [(type: PlayerType, piece: GamePiece)]
    private lazy var currentPlayerIndex = 0
    private lazy var boardLayout: [(location: Location, piece: GamePiece)] = []
    
    weak var delegate:GameDelegate?
    
    private lazy var winConditionMap: Dictionary <WinCondition, [Location]> = [
        WinCondition.leftDiagonal: [Location.topLeft,
                                    Location.middleCenter,
                                    Location.bottomRight],
        WinCondition.rightDiagonal: [Location.topRight,
                                     Location.middleCenter,
                                     Location.bottomLeft],
        WinCondition.horizontalTop: [Location.topLeft,
                                     Location.topCenter,
                                     Location.topRight],
        WinCondition.horizontalMiddle: [Location.middleLeft,
                                        Location.middleCenter,
                                        Location.middleRight],
        WinCondition.horizontalBottom: [Location.bottomLeft,
                                        Location.bottomCenter,
                                        Location.bottomRight],
        WinCondition.verticalLeft: [Location.topLeft,
                                    Location.middleLeft,
                                    Location.bottomLeft],
        WinCondition.verticalCenter: [Location.topCenter,
                                      Location.middleCenter,
                                      Location.bottomCenter],
        WinCondition.verticalRight: [Location.topRight,
                                     Location.middleRight,
                                     Location.bottomRight]
    ]
    
    // MARK: - Initializers
    
    init(firstPlayerType: PlayerType = PlayerType.human,
         firstPlayerPiece: GamePiece = GamePiece.x,
         secondPlayerType: PlayerType = PlayerType.computer) {
        let secondPlayerPiece = (firstPlayerPiece == GamePiece.x) ? GamePiece.o : GamePiece.x
        players = [(firstPlayerType, firstPlayerPiece),
                   (secondPlayerType, secondPlayerPiece)]
    }
    
    // MARK: - Turn Phases
    
    func takeNextTurn(playerIndex: Int, selectedLocation: Location) {
        if playerIndex != currentPlayerIndex { // ensure play is in order
            return
        }
        
        let success = recordSelectedLocation(selectedLocation: selectedLocation)
        
        if success {  // ensure valid, non-occupied location
            checkEndGameCondition()
            endTurn()

            if currentPlayer().type == PlayerType.computer {
                triggerComputerTurn()
            }
        }
    }
    
    func recordSelectedLocation(selectedLocation: Location) -> Bool {
        if occupiedLocations().contains(selectedLocation){
            return false
        }
        
        boardLayout.append((location: selectedLocation, currentPlayer().piece))
        delegate?.didRecordMove(location: selectedLocation, piece: currentPlayer().piece)
        return true
    }
    
    func checkEndGameCondition () {
        
        let winConditions = self.winConditions(piece: currentPlayer().piece)
        if winConditions != nil && (winConditions?.count)! > 0 {
            delegate?.didWinGame(player: currentPlayer(), winConditions: winConditions!)
        } else if availableLocations().count <= 0 {
            delegate?.didEndGameWithDraw()
        }
    }
    
    func winConditions(piece: GamePiece) -> Array<WinCondition>? {
        let pieceLocations = locationsForPiece(piece: piece)
        if pieceLocations.count < 3 {
            return nil
        }
        
        var winConditions = Array<WinCondition>()
        for (winCondition, winConditionLocations) in winConditionMap{
            if pieceLocations.contains(array: winConditionLocations){
                winConditions.append(winCondition)
            }
        }
        return winConditions
    }
    
    func endTurn () {
        currentPlayerIndex = (currentPlayerIndex == 0) ? 1 : 0
        delegate?.didEndTurn()
    }
    
    func triggerComputerTurn() {
        if availableLocations().count > 0 {
            let location = randomAvailableLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(0.5)) {
                self.takeNextTurn(playerIndex: self.currentPlayerIndex,
                                  selectedLocation: location)
            }
        }
    }
    
    // MARK: - Helper Functions
    
    func currentPlayer () -> (type: PlayerType, piece: GamePiece) {
        return players[currentPlayerIndex]
    }
    
    func occupiedLocations () -> Array<Location> {
        return boardLayout.map { $0.location }
    }
    
    func availableLocations () -> Array<Location> {
        return Location.all().filter { !occupiedLocations().contains($0) }
    }
    
    func randomAvailableLocation() -> Location {
        let locations = availableLocations()
        let randomIndex = Int(arc4random_uniform(UInt32(locations.count)))
        return locations[randomIndex]
    }
    
    func locationsForPiece (piece: GamePiece) -> Array<Location> {
        return boardLayout.filter{$0.piece == piece}.map{$0.location}
    }
    
}

extension Array where Element: Equatable {
    func contains(array: [Element]) -> Bool {
        for item in array {
            if !self.contains(item) { return false }
        }
        return true
    }
}
