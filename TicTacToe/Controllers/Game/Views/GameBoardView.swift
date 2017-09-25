//
//  GameBoardView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/2/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit


protocol GameBoardViewDelegate: class {
    func didDrawBoard()
    func didSelectCell(location: Location)
    func didEraseBoard()
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
    
    @IBOutlet weak var eraseView: EraseView!
    
    weak var delegate:GameBoardViewDelegate?
    
    private var _pieceLocationMap: Dictionary<Location, PieceView>?

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
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,
                                 UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    var pieceLocationMap: Dictionary<Location, PieceView> {
        set (pieceLocationMap){}
        get {
            if _pieceLocationMap == nil {
                _pieceLocationMap = [
                    Location.topLeft: topLeftPiece,
                    Location.topCenter: topCenterPiece,
                    Location.topRight: topRightPiece,
                    Location.middleLeft: middleLeftPiece,
                    Location.middleCenter: middleCenterPiece,
                    Location.middleRight: middleRightPiece,
                    Location.bottomLeft: bottomLeftPiece,
                    Location.bottomCenter: bottomCenterPiece,
                    Location.bottomRight: bottomRightPiece
                ]

            }
            return _pieceLocationMap!
        }
    }
    

    // MARK: - Draw On Board

    func drawBoard() {
        let animationSpeed = 0.15
        leftVerticalLine.drawLine(withDuration: animationSpeed)
        rightVerticalLine.drawLine(withDuration: animationSpeed, delay: animationSpeed)
        topHorizontalLine.drawLine(withDuration: animationSpeed, delay:(animationSpeed * 2))
        bottomHorizontalLine.drawLine(withDuration: animationSpeed, delay: (animationSpeed * 3)) { [weak self] () in
            guard let strongSelf = self else { return }
            
            strongSelf.delegate?.didDrawBoard()
        }
    }
    
    func draw(piece: GamePiece, location: Location) {
        let pieceView = pieceLocationMap[location]
        pieceView?.drawPiece(piece: piece, duration: 0.2)
    }
    
    func eraseGameBoard() {
        eraseView.drawLine(withDuration: 0.75) { [weak self] () in
            guard let strongSelf = self else { return }
            
            // reset lines
            strongSelf.leftVerticalLine.resetDrawing()
            strongSelf.rightVerticalLine.resetDrawing()
            strongSelf.topHorizontalLine.resetDrawing()
            strongSelf.bottomHorizontalLine.resetDrawing()
            
            // reset game pieces
            strongSelf.topLeftPiece.resetDrawing()
            strongSelf.topCenterPiece.resetDrawing()
            strongSelf.topRightPiece.resetDrawing()
            strongSelf.middleLeftPiece.resetDrawing()
            strongSelf.middleCenterPiece.resetDrawing()
            strongSelf.middleRightPiece.resetDrawing()
            strongSelf.bottomLeftPiece.resetDrawing()
            strongSelf.bottomCenterPiece.resetDrawing()
            strongSelf.bottomRightPiece.resetDrawing()
            
            // reset erase view
            strongSelf.eraseView.resetDrawing()
            
            strongSelf.delegate?.didEraseBoard()
        }
    }
    
    // MARK: - Action Handling
    
    @IBAction func cellSelected(_ sender: UIButton) {
        let location = Location(rawValue: sender.tag)
        delegate?.didSelectCell(location: location!)
    }
}
