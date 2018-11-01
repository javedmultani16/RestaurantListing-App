//
//  AlertView.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//


//https://github.com/thellimist/EZAlertController

import UIKit

public class NIPLAlertController {
    
    //==========================================================================================================
    // MARK: - Singleton
    //==========================================================================================================
    
    class var instance : NIPLAlertController {
        struct Static {
            static let inst : NIPLAlertController = NIPLAlertController ()
        }
        return Static.inst
    }
    
    //==========================================================================================================
    // MARK: - Private Functions
    //==========================================================================================================
    
    private func topMostController() -> UIViewController? {
        
        var presentedVC = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentedVC?.presentedViewController
        {
            presentedVC = pVC
        }
        
        if presentedVC == nil {
            //DLog(" You don't have any views set. You may be calling in viewdidload. Try viewdidappear.")
        }
        return presentedVC
    }
    
    
    //==========================================================================================================
    // MARK: - Class Functions
    //==========================================================================================================
    
    public class func alert(title: String) -> UIAlertController {
        return alert(title: title, message: "")
    }
    
    public class func alert(title: String, message: String) -> UIAlertController {

        return alert(title: title, message: message, buttons: ["OK"], tapBlock: nil)
    }
    
    public class func alert(title: String, message: String, acceptMessage: String, acceptBlock: @escaping () -> ()) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let acceptButton = UIAlertAction(title: acceptMessage, style: .default, handler: { (action: UIAlertAction) in
            acceptBlock()
        })
        alert.addAction(acceptButton)
        
        instance.topMostController()?.present(alert, animated: true, completion: nil)
        return alert
    }
    
    public class func alert(title: String, message: String, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert, buttons: buttons, tapBlock: tapBlock)
        instance.topMostController()?.present(alert, animated: true, completion: nil)
        return alert
    }
    
    public class func actionSheet(title: String, message: String, sourceView: UIView, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: ((title.length == 0) ? nil : title) , message: ((message.length == 0) ? nil : message), preferredStyle: UIAlertControllerStyle.actionSheet)
        for action in actions {
            alert.addAction(action)
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        alert.popoverPresentationController?.sourceView = sourceView
        alert.popoverPresentationController?.sourceRect = sourceView.bounds
        instance.topMostController()?.present(alert, animated: true, completion: nil)
        return alert
    }
    
    public class func actionSheet(title: String, message: String, sourceView: UIView, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) -> UIAlertController{
        let alert = UIAlertController(title: ((title.length == 0) ? nil : title) , message: ((message.length == 0) ? nil : message), preferredStyle: .actionSheet, buttons: buttons, tapBlock: tapBlock)
        alert.popoverPresentationController?.sourceView = sourceView
        alert.popoverPresentationController?.sourceRect = sourceView.bounds
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        instance.topMostController()?.present(alert, animated: true, completion: nil)
        return alert
    }
    
}


private extension UIAlertController {
    convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, buttons:[String], tapBlock:((UIAlertAction,Int) -> Void)?) {
        self.init(title: title, message: message, preferredStyle:preferredStyle)
        var buttonIndex = 0
        for buttonTitle in buttons {
            let action = UIAlertAction(title: buttonTitle, preferredStyle: .default, buttonIndex: buttonIndex, tapBlock: tapBlock)
            buttonIndex += 1
            self.addAction(action)
        }
    }
}



private extension UIAlertAction {
    convenience init(title: String?, preferredStyle: UIAlertActionStyle, buttonIndex:Int, tapBlock:((UIAlertAction,Int) -> Void)?) {
        self.init(title: title, style: .default) { (action:UIAlertAction) in
            if let block = tapBlock {
                block(action,buttonIndex)
            }
        }
    }
}
