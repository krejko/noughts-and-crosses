//
//  PieceView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/4/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit

class PieceView : LineView {
    
    //MARK: - Properties
    
    var piece: GamePiece?
    private var _rightLineLengthPercent = 0.0
    private var _rightDrawingTimer: Timer?
    private var _halfDuration = 0.0
    private var _xStrokeWidth = 0.0
    
    
    var rightLineLengthPercent: Double {
        set (newLineLengthPercent){
            if newLineLengthPercent > 1.0 {
                _rightLineLengthPercent = 1.0
            } else if newLineLengthPercent < 0.0 {
                _rightLineLengthPercent = 0.0
            } else {
                _rightLineLengthPercent = newLineLengthPercent
            }
            setNeedsDisplay()
        }
        get {
            return _rightLineLengthPercent
        }
    }
    
    var xStrokeWidth: Double{
        set (newStrokeWidth){
            _xStrokeWidth = newStrokeWidth
        }
        get {
            if _xStrokeWidth == 0.0 {
                return Double(self.frame.width) * 0.25
            }else {
                return _xStrokeWidth
            }
        }
    }
    
    //MARK: - Drawing
    
    override func resetDrawing () {
        super.resetDrawing()
        rightLineLengthPercent = 0.0
        setNeedsDisplay()
    }
    
    func drawPiece(piece: GamePiece, duration: Double = 0, delay: Double = 0){
        self.piece = piece
        if piece == GamePiece.x {
            drawXPiece(withDuration: duration, delay: delay)
        }else{
            super.drawLine(withDuration:duration, delay: delay)
        }
    }
    
    func drawXPiece(withDuration: Double, delay: Double) {
        _halfDuration = withDuration * 0.5;
        self.drawLine(withDuration: _halfDuration, delay: delay)
    }
    
    func drawRightLine(withDuration: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {[weak self] () in
            guard let strongSelf = self else { return }
            strongSelf._rightDrawingTimer = Timer.scheduledTimer(timeInterval: TimeInterval(strongSelf.animationFrequency),
                                                                 target: strongSelf,
                                                                 selector: #selector(PieceView.updateRightLine),
                                                                 userInfo: nil,
                                                                 repeats: true)
        }
    }
    
    func updateRightLine()  {
        rightLineLengthPercent += drawingIncrementPercent
        
        if rightLineLengthPercent >= 1.0 {
            invalidateRightTimer()
        }
    }
    
    func invalidateRightTimer() {
        if _rightDrawingTimer != nil {
            _rightDrawingTimer!.invalidate()
            _rightDrawingTimer = nil
        }
    }
    
    override func updateLine()  {
        super.updateLine()
        // When the first half of the x finishes drawing, draw second half
        if lineLengthPercent >= 1.0 && piece == GamePiece.x {
            drawRightLine(withDuration: _halfDuration)
        }
    }
    
    override func draw(_ rect: CGRect) {
        if piece == GamePiece.x {
            Drawer.drawX(rect: rect,
                         leftLinePercent: CGFloat(lineLengthPercent),
                         showLeftLine: (lineLengthPercent > 0.1),
                         rightLinePercent: CGFloat(rightLineLengthPercent),
                         showRightLine: (rightLineLengthPercent > 0.1),
                         xStrokeWidth: CGFloat(xStrokeWidth))
        } else if piece == GamePiece.o {
            Drawer.drawO(rect: rect,
                         oStrokeWidth: self.frame.width * 0.25,
                         oLinePercent: CGFloat(lineLengthPercent))
        }
    }
}
