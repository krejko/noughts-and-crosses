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
    //Lines
    @IBOutlet weak var leftVerticalLine: VerticalLineView!
    @IBOutlet weak var rightVerticalLine: VerticalLineView!
    @IBOutlet weak var topHorizontalLine: HorizontalLineView!
    @IBOutlet weak var bottomHorizontalLine: HorizontalLineView!
    //Pieces
    @IBOutlet weak var topLeftPiece: PieceView!
    @IBOutlet weak var topCenterPiece: PieceView!
    @IBOutlet weak var topRightPiece: PieceView!
    @IBOutlet weak var middleLeftPiece: PieceView!
    @IBOutlet weak var middleCenterPiece: PieceView!
    @IBOutlet weak var middleRightPiece: PieceView!
    @IBOutlet weak var bottomLeftPiece: PieceView!
    @IBOutlet weak var bottomCenterPiece: PieceView!
    @IBOutlet weak var bottomRightPiece: PieceView!
    //Win Views
    @IBOutlet weak var leftDiagonalWinLine: leftDiagonalLine!
    @IBOutlet weak var rightDiagonalWinLine: rightDiagonalLine!
    @IBOutlet weak var leftVerticalWinLine: VerticalLineView!
    @IBOutlet weak var centerVerticalWinLine: VerticalLineView!
    @IBOutlet weak var rightVerticalWinLine: VerticalLineView!
    @IBOutlet weak var topHorizontalWinLine: HorizontalLineView!
    @IBOutlet weak var middleHorizontalWinLine: HorizontalLineView!
    @IBOutlet weak var bottomHorizontalWinLine: HorizontalLineView!
    // Erase View
    @IBOutlet weak var eraseView: EraseView!
    
    // Delegate
    weak var delegate:GameBoardViewDelegate?
    
    // Maps
    private var _pieceLocationMap: Dictionary<Location, PieceView>?
    private var _winConditionMap: Dictionary<WinCondition, LineView>?
    
    // Constants
    let lineAnimationSpeed = 0.15

    
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
        self.eraseView.color = UIColor.Theme.lightTheme().backgroundColor
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    // MARK: Maps
    
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
    
    var winConditionMap: Dictionary<WinCondition, LineView> {
        set(winConditionMap) {}
        get {
            if _winConditionMap == nil {
                _winConditionMap = [
                    WinCondition.leftDiagonal: leftDiagonalWinLine,
                    WinCondition.rightDiagonal: rightDiagonalWinLine,
                    WinCondition.verticalLeft: leftVerticalWinLine,
                    WinCondition.verticalCenter: centerVerticalWinLine,
                    WinCondition.verticalRight: rightVerticalWinLine,
                    WinCondition.horizontalTop: topHorizontalWinLine,
                    WinCondition.horizontalMiddle: middleHorizontalWinLine,
                    WinCondition.horizontalBottom: bottomHorizontalWinLine
                ]
            }
            return _winConditionMap!
        }
    }

    // MARK: - Draw On Board

    func drawBoard() {
        leftVerticalLine.drawLine(withDuration: lineAnimationSpeed)
        rightVerticalLine.drawLine(withDuration: lineAnimationSpeed, delay: lineAnimationSpeed)
        topHorizontalLine.drawLine(withDuration: lineAnimationSpeed, delay:(lineAnimationSpeed * 2))
        bottomHorizontalLine.drawLine(withDuration: lineAnimationSpeed, delay: (lineAnimationSpeed * 3)) { [weak self] () in
            guard let strongSelf = self else { return }
            
            strongSelf.delegate?.didDrawBoard()
        }
    }
    
    func draw(piece: GamePiece, location: Location) {
        let pieceView = pieceLocationMap[location]
        pieceView?.drawPiece(piece: piece, duration: 0.2)
    }
    
    func draw(winConditions: Array<WinCondition>, color: UIColor) {
        var delay = lineAnimationSpeed
        for winCondition in winConditions{
            let winConditionView = winConditionMap[winCondition]
            winConditionView?.color = color
            winConditionView?.drawLine(withDuration: lineAnimationSpeed, delay: delay)
            delay += lineAnimationSpeed
        }
    }
    
    func eraseGameBoard() {
        eraseView.isHidden = false
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
            
            // reset win lines
            strongSelf.leftDiagonalWinLine.resetDrawing()
            strongSelf.rightDiagonalWinLine.resetDrawing()
            strongSelf.leftVerticalWinLine.resetDrawing()
            strongSelf.centerVerticalWinLine.resetDrawing()
            strongSelf.rightVerticalWinLine.resetDrawing()
            strongSelf.topHorizontalWinLine.resetDrawing()
            strongSelf.middleHorizontalWinLine.resetDrawing()
            strongSelf.bottomHorizontalWinLine.resetDrawing()
            
            // reset erase view
            strongSelf.eraseView.isHidden = true
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
