//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/2/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit

@IBDesignable
class GameBoardView: UIView {

    
    @IBOutlet var view: UIView!
    @IBOutlet weak var leftVerticalLine: VerticalLineView!
    @IBOutlet weak var rightVerticalLine: VerticalLineView!
    @IBOutlet weak var topHorizontalLine: HorizontalLineView!
    @IBOutlet weak var bottomHorizontalLine: HorizontalLineView!

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        view = loadViewFromNib() 
        view.frame = bounds
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    // MARK: - Board Setup

    func drawBoard(animated: Bool) {
        let animationSpeed = CGFloat(0.15)
        self.leftVerticalLine.drawLine(withDuration: animationSpeed)
        self.rightVerticalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed))
        self.topHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 2))
        self.bottomHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 3))
    }
}
