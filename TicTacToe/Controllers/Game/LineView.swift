//
//  VerticalLineView.swift
//  TicTacToe
//
//  Created by Kevin Rejko on 9/2/17.
//  Copyright © 2017 Kevin Rejko. All rights reserved.
//

import UIKit


class LineView: UIView {
    
    private let _animationFrequency: CGFloat = 0.05
    private var _lineLengthPercent : CGFloat = 0
    private var _drawingTimer: Timer?
    private var _drawingIncrementPercent: CGFloat = 0.1
    
    var lineLengthPercent: CGFloat {
        set (newLineLengthPercent){
            if newLineLengthPercent > 1.0 {
                _lineLengthPercent = 1.0
            } else if newLineLengthPercent < 0.0 {
                _lineLengthPercent = 0.0
            } else {
                _lineLengthPercent = newLineLengthPercent
            }
            self.setNeedsDisplay()
        }
        get {
            return _lineLengthPercent
        }
    }
    
    func drawLine(withDuration: CGFloat = 1, delay: Double = 0.0) {
        self.setDrawingIncrement(withDuration: withDuration)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self._drawingTimer = Timer.scheduledTimer(timeInterval: TimeInterval(self._animationFrequency),
                                                      target: self,
                                                      selector: #selector(self.updateLine),
                                                      userInfo: nil,
                                                      repeats: true)
        }
    }
    
    func setDrawingIncrement(withDuration: CGFloat) {
        if (withDuration <= 0) {
            self._drawingIncrementPercent = CGFloat(1.0)
        } else {
            self._drawingIncrementPercent = (self._animationFrequency / withDuration)
        }
    }
    
    func updateLine()  {
        self.lineLengthPercent += self._drawingIncrementPercent

        if self.lineLengthPercent >= 1.0 {
            _drawingTimer!.invalidate()
            _drawingTimer = nil
        }
    }
}

class VerticalLineView: LineView {
    override func draw(_ rect: CGRect) {
        Drawer.drawVertical_line(vertical_line_length: self.lineLengthPercent, vertical_line_frame: rect)
    }
}

class HorizontalLineView: LineView {
    
    override func draw(_ rect: CGRect) {
        Drawer.drawHorizontal_line(horizontal_line_length: self.lineLengthPercent, horizontal_line_frame: rect)
    }
}

