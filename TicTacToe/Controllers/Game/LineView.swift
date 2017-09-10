//
//  VerticalLineView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/2/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit


class LineView: UIView {
    
    //MARK: - Properties
    
    let animationFrequency: Double = 0.01
    private var _lineLengthPercent : Double = 0
    private var _drawingTimer: Timer?
    var drawingIncrementPercent: Double = 0.0
    
    var lineLengthPercent: Double {
        set (newLineLengthPercent){
            if newLineLengthPercent > 1.0 {
                _lineLengthPercent = 1.0
            } else if newLineLengthPercent < 0.0 {
                _lineLengthPercent = 0.0
            } else {
                _lineLengthPercent = newLineLengthPercent
            }
            setNeedsDisplay()
        }
        get {
            return _lineLengthPercent
        }
    }
    
    //MARK: - Drawing
    
    func resetDrawing() {
        _lineLengthPercent = 0
        setNeedsDisplay()
    }
    
    func drawLine(withDuration: Double = 1,
                  delay: Double = 0.0) {
        resetDrawing()
        drawingIncrementPercent = calculateDrawingIncrementPercent(withDuration: withDuration, frequency: animationFrequency)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.invalidateTimer()
            self._drawingTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self.animationFrequency),
                                                      target: self,
                                                      selector: #selector(LineView.updateLine),
                                                      userInfo: nil,
                                                      repeats: true)
        }
    }
    
    func updateLine()  {
        lineLengthPercent += drawingIncrementPercent
        
        if lineLengthPercent >= 1.0 {
            invalidateTimer()
        }
    }
    
    func invalidateTimer() {
        if _drawingTimer != nil {
            _drawingTimer!.invalidate()
            _drawingTimer = nil
        }
    }
    
    //MARK: - Calculations
  
    func calculateDrawingIncrementPercent(withDuration: Double, frequency: Double = 0.05) -> Double {
        if (withDuration <= 0) {
            return 1.0
        } else {
            return (animationFrequency / withDuration)
        }
    }

}

//MARK: - Subclasses

class VerticalLineView: LineView {
    override func draw(_ rect: CGRect) {
        Drawer.drawVerticalLine(verticalLinePercent: CGFloat(lineLengthPercent), verticalLineFrame: rect)
    }
}

class HorizontalLineView: LineView {
    override func draw(_ rect: CGRect) {
        Drawer.drawHorizontalLine(horizontalLinePercent: CGFloat(lineLengthPercent), horizontalLineFrame: rect)
    }
}

class EraseView: LineView {
    override func draw(_ rect: CGRect) {
        Drawer.drawErase(backgroundColor: UIColor.init(hex: 0xF2F2F4),
                         erasePercent: CGFloat(lineLengthPercent),
                         eraseFrame: rect)
    }
}

