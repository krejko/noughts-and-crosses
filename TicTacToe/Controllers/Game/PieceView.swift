//
//  PieceView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/4/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit

class PieceView : LineView {
    
    var piece: GamePiece?
    private var _rightLineLengthPercent : CGFloat = 0

    var rightLineLengthPercent: CGFloat {
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

    
    func setPiece(piece: GamePiece, duration: CGFloat = 0){
        self.piece = piece
        drawLine(withDuration: duration,
                 delay: 0,
                 sel: #selector(PieceView.updateLine))
    }
    
    override func drawLine(withDuration: CGFloat, delay: Double, sel: Selector) {
        if piece == GamePiece.x {
            let halfDuration = withDuration * 0.5;
            super.drawLine(withDuration: halfDuration)
            super.drawLine(withDuration: halfDuration,
                           delay: Double(halfDuration),
                           sel: #selector(self.updateRightLine))
        }else{
            super.drawLine(withDuration:withDuration,
                           delay: delay,
                           sel: sel)
        }

    }
    
    func updateRightLine()  {
        rightLineLengthPercent += _drawingIncrementPercent
        
        if rightLineLengthPercent >= 1.0 {
            _drawingTimer!.invalidate()
            _drawingTimer = nil
        }
    }
    
    override func draw(_ rect: CGRect) {
        let strokeWidth = rect.width * 0.25
        if piece == GamePiece.x {
            Drawer.drawX(rect: rect, left_length: lineLengthPercent, right_length: rightLineLengthPercent, x_stroke_width: strokeWidth)
        } else if piece == GamePiece.o {
            Drawer.drawO(rect: rect, o_stroke_width: strokeWidth, o_length: lineLengthPercent)
        }
    }
}
