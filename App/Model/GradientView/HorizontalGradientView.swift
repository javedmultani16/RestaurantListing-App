//
//  HorizontalGradientView.swift
//  iOS
//
//  Created by Javed Multani on 28/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable final class HorizontalGradientView: UIView {
    
    @IBInspectable var leftColor: UIColor = CLEAR_COLOR
    @IBInspectable var rightColor: UIColor = CLEAR_COLOR
    
    override func draw(_ rect: CGRect) {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.0)
        
        self.layer.addSublayer(gradient)
        
        super.draw(rect)
    }
    
    
    init(frame: CGRect, leftColor: UIColor, rightColor: UIColor) {
        super.init(frame: frame)
        self.leftColor = leftColor
        self.rightColor = rightColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
