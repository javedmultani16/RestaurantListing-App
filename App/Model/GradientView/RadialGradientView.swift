//
//  RadialGradientView.swift
//  iOS
//
//  Created by Javed Multani on 28/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//


import Foundation
import UIKit

@IBDesignable class RadialGradientView: UIView {
    
    @IBInspectable var internalColor: UIColor = CLEAR_COLOR
    @IBInspectable var externalColor: UIColor = CLEAR_COLOR
    
    override func draw(_ rect: CGRect) {
        let colors = [internalColor.cgColor, externalColor.cgColor] as CFArray
        let endRadius = max(frame.width, frame.height) / 2
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        UIGraphicsGetCurrentContext()!.drawRadialGradient(gradient!, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: endRadius, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        super.draw(rect)
    }
    
    
    init(frame: CGRect, internalColor: UIColor, externalColor: UIColor) {
        super.init(frame: frame)
        self.internalColor = internalColor
        self.externalColor = externalColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
