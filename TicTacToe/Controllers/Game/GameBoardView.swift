//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/2/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit


protocol GameBoardViewDelegate: class {
    func didSelectCell(cellLocation: CellLocation)
}


@IBDesignable
class GameBoardView: UIView {

    
    @IBOutlet var view: UIView!
    @IBOutlet weak var leftVerticalLine: VerticalLineView!
    @IBOutlet weak var rightVerticalLine: VerticalLineView!
    @IBOutlet weak var topHorizontalLine: HorizontalLineView!
    @IBOutlet weak var bottomHorizontalLine: HorizontalLineView!
    
    weak var delegate:GameBoardViewDelegate?


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
        leftVerticalLine.drawLine(withDuration: animationSpeed)
        rightVerticalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed))
        topHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 2))
        bottomHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 3))
    }
    
    // MARK: - Action Handling
    
    @IBAction func cellSelected(_ sender: UIButton) {
        let location = CellLocation(rawValue: sender.tag)
        delegate?.didSelectCell(cellLocation: location!)
    }
}
