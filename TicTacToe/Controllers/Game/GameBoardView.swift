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
    
    @IBOutlet weak var topLeftPiece: PieceView!
    @IBOutlet weak var topCenterPiece: PieceView!
    @IBOutlet weak var topRightPiece: PieceView!
    @IBOutlet weak var middleLeftPiece: PieceView!
    @IBOutlet weak var middleCenterPiece: PieceView!
    @IBOutlet weak var middleRightPiece: PieceView!
    @IBOutlet weak var bottomLeftPiece: PieceView!
    @IBOutlet weak var bottomCenterPiece: PieceView!
    @IBOutlet weak var bottomRightPiece: PieceView!
    
    weak var delegate:GameBoardViewDelegate?
    
    private var _pieceLocationMap: Dictionary<CellLocation, PieceView>?

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
    
    var pieceLocationMap: Dictionary<CellLocation, PieceView> {
        set (pieceLocationMap){}
        get {
            if _pieceLocationMap == nil {
                _pieceLocationMap = [
                    CellLocation.topLeft: topLeftPiece,
                    CellLocation.topCenter: topCenterPiece,
                    CellLocation.topRight: topRightPiece,
                    CellLocation.middleLeft: middleLeftPiece,
                    CellLocation.middleCenter: middleCenterPiece,
                    CellLocation.middleRight: middleRightPiece,
                    CellLocation.bottomLeft: bottomLeftPiece,
                    CellLocation.bottomCenter: bottomCenterPiece,
                    CellLocation.bottomRight: bottomRightPiece
                ]

            }
            return _pieceLocationMap!
        }
    }
    

    // MARK: - Draw On Board

    func drawBoard(animated: Bool) {
        let animationSpeed = CGFloat(0.15)
        leftVerticalLine.drawLine(withDuration: animationSpeed)
        rightVerticalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed))
        topHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 2))
        bottomHorizontalLine.drawLine(withDuration: animationSpeed, delay: Double(animationSpeed * 3))
    }
    
    func draw(piece: GamePiece, location: CellLocation) {
        let pieceView = pieceLocationMap[location]
        pieceView?.setPiece(piece: piece, duration: 0.2)
    }
    
    // MARK: - Action Handling
    
    @IBAction func cellSelected(_ sender: UIButton) {
        let location = CellLocation(rawValue: sender.tag)
        delegate?.didSelectCell(cellLocation: location!)
    }
}
