//
//  VerticalGradientView.swift
//  iOS
//
//  Created by Javed Multani on 28/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable final class VerticalGradientView: UIView {
    
    @IBInspectable var topColor: UIColor = UIColor.clear
    @IBInspectable var bottomColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: self.frame.size.width,
                                height: self.frame.size.height)
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        layer.addSublayer(gradient)
        super.draw(rect)
    }
    
    
    init(frame: CGRect, topColor: UIColor, bottomColor: UIColor) {
        super.init(frame: frame)
        self.topColor = topColor
        self.bottomColor = bottomColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
