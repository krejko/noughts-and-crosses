//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 8/31/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
   
    
    @IBOutlet weak var gameBoardView: GameBoardView!
    @IBOutlet weak var nextPieceView: PieceView!
    var game: Game = Game()
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBoardView.delegate = self
        nextPieceView.xStrokeWidth = Double(nextPieceView.frame.width) * 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameBoardView.drawBoard()
        game = Game()
        game.delegate = self
        self .updateNextPieceView(delay: 0.75)
    }
    
    func updateNextPieceView (delay: Double = 0) {
        nextPieceView.drawPiece(piece: game.currentPlayer().piece,
                               duration: 0.25,
                               delay: delay)
    }
    
    func triggerComputerTurn() {
        if game.availableLocations().count > 0 {
            let location = game.randomAvailableLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(0.5)) {
                //TODO: put in actual player index
                self.game.takeNextTurn(playerIndex: 1,
                                  selectedLocation: location)
            }
        }
    }
    
    @IBAction func restartButtonPressed(_ sender: Any) {
        gameBoardView.resetGameBoard()
    }
}

extension GameViewController: GameBoardViewDelegate {
    func didSelectCell(location: Location) {
        //TODO: put in actual player index
        game.takeNextTurn(playerIndex: 0, selectedLocation: location)
    }
}

extension GameViewController: GameDelegate {
    func didRecordMove(location: Location, piece: GamePiece) {
        gameBoardView.draw(piece: piece, location: location)
    }
    
    func didEndTurn (){
        updateNextPieceView(delay: 0.25)
        
        if game.currentPlayer().type == PlayerType.computer {
            triggerComputerTurn()
        }

    }
    
    func didWinGame(player: (type: PlayerType, piece: GamePiece),
                    winConditions: Array<WinCondition>) {
        print("\(player.piece) is the winner with ")
        dump(winConditions)
    }
    
    func didEndGameWithDraw () {
        print("Game ends in draw")
    }

}

