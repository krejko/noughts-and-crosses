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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameBoardView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        gameBoardView.drawBoard(animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GameViewController: GameBoardViewDelegate {
    func didSelectCell(cellLocation: CellLocation) {
        print("Cell Selected: \(String(describing: cellLocation))" )
    }
}
