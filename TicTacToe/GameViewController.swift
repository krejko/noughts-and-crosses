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
    @IBOutlet weak var leftVerticalLine: VerticalLineView!
    @IBOutlet weak var rightVerticalLine: VerticalLineView!
    @IBOutlet weak var topHorizontalLine: HorizontalLineView!
    @IBOutlet weak var bottomHorizontalLine: HorizontalLineView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.gameBoardView.drawBoard(animated: animated)
        let animationSpeed = CGFloat(0.15)
        self.leftVerticalLine.drawLine(withDuration: animationSpeed)
        self.rightVerticalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed))
        self.topHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 2))
        self.bottomHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 3))

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

