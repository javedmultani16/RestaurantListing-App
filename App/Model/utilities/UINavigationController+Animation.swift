//
//  UINavigationController+Animation.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public extension UINavigationController {
    
    /**
     Pop current view controller to previous view controller.
     
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func pop(transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }
    
    /**
     Push a new view controller on the view controllers's stack.
     
     - parameter vc:       view controller to push.
     - parameter type:     transition animation type.
     - parameter duration: transition animation duration.
     */
    func push(viewController vc: UIViewController, transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }
    
    private func addTransition(transitionType type: String = kCATransitionFade, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }
    
}
