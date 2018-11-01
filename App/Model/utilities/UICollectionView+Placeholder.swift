//
//  UICollectionView+Placeholder.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import NVActivityIndicatorView


private let kPlaceholderRightPadding : CGFloat = 10.0
private let kPlaceholderLeftPadding : CGFloat = 10.0
private let kPlaceholderTopPadding : CGFloat = 10.0
private let kPlaceholderBottomPadding : CGFloat = 10.0



public extension UICollectionView {
    
    
    public func reloadData(withPlaceholderString placeholderString: String) {
        backgroundView = nil
        if numberOfSections == 0 || (numberOfItems(inSection: 0) == 0 || numberOfItems(inSection: 0) == NSNotFound) {
            if (placeholderString.count ) > 0 {
                let lblEmpty: UILabel? = getLabel()
                lblEmpty?.text = placeholderString
                backgroundView = lblEmpty
            }
        }
        else {
            backgroundView = nil
        }
        reloadData()
    }
    
    
    public func reloadDataWithLoader(_ isLoader : Bool) {
        runOnMainThread { 
            let loader : NVActivityIndicatorView  = createSmallLoaderInView()
            if self.numberOfSections == 0 || (self.numberOfItems(inSection: 0) == 0 || self.numberOfItems(inSection: 0) == NSNotFound) {
                if isLoader {
                    let viewAdd = UIView(frame: CGRect(x: kPlaceholderLeftPadding, y: kPlaceholderTopPadding, width: self.frame.width - kPlaceholderRightPadding - kPlaceholderLeftPadding, height: self.frame.height - kPlaceholderBottomPadding))
                    loader.startAnimating()
                    loader.center = viewAdd.center
                    viewAdd.addSubview(loader)
                    self.backgroundView = viewAdd
                }
                else {
                    loader.stopAnimating()
                    self.backgroundView = nil
                }
            }
            else {
                loader.stopAnimating()
                self.backgroundView = nil
            }
            self.reloadData()
        }
    }
    
    func reloadData(withPlaceholderString placeholderString: String, lookupsection section: Int) {
        backgroundView = nil
        if numberOfSections == 0 && (numberOfItems(inSection: section) == 0 || numberOfItems(inSection: section) == NSNotFound) {
            if (placeholderString.count ) > 0 {
                let lblEmpty: UILabel? = getLabel()
                lblEmpty?.text = placeholderString
                lblEmpty?.textColor = UIColor.lightGray
                backgroundView = lblEmpty
            }
        }
        else {
            backgroundView = nil
        }
        reloadData()
    }
    
    func reloadData(_ placeholderString: String, _ placeholderColor: UIColor) {
        backgroundView = nil
        if numberOfSections == 0 || (numberOfItems(inSection: 0) == 0 || numberOfItems(inSection: 0) == NSNotFound) {
            if (placeholderString.count ) > 0 {
                let lblEmpty: UILabel? = getLabel()
                lblEmpty?.text = placeholderString
                lblEmpty?.textColor = placeholderColor
                backgroundView = lblEmpty
            }
        }
        else {
            backgroundView = nil
        }
        reloadData()
    }
    
    func getLabel() -> UILabel {
        let lblEmpty = UILabel(frame: CGRect(x: kPlaceholderLeftPadding, y: kPlaceholderTopPadding, width: self.frame.width - kPlaceholderRightPadding - kPlaceholderLeftPadding, height: frame.height - kPlaceholderBottomPadding))
        lblEmpty.numberOfLines = 3
        lblEmpty.textAlignment = .center
        lblEmpty.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblEmpty.font = THEME_FONT_BOLD(size:14.0)
        lblEmpty.sizeThatFits(lblEmpty.frame.size)
        return lblEmpty
    }
    
    func getLabelForFontAwesome() -> UILabel {
        let lblEmpty = UILabel(frame: CGRect(x: CGFloat(kPlaceholderLeftPadding), y: CGFloat(kPlaceholderTopPadding), width: CGFloat(frame.width - kPlaceholderRightPadding - kPlaceholderLeftPadding), height: CGFloat(frame.height - kPlaceholderBottomPadding)))
        lblEmpty.numberOfLines = 1
        lblEmpty.textAlignment = .center
        lblEmpty.lineBreakMode = NSLineBreakMode.byWordWrapping
//        lblEmpty.font = FONT_AWESOME(size: 15.0)
        lblEmpty.sizeThatFits(lblEmpty.frame.size)
        
        return lblEmpty
    }
    
    
    func customAttributedPlaceholderString(_ mainString: String, withSubstring substring: String) -> NSMutableAttributedString {
        let range: NSRange = (mainString as NSString).range(of: substring)
        let textAttributes: [AnyHashable: Any] = [kCTFontAttributeName: THEME_FONT_REGULAR(size: 14.0)]
        let myString = NSMutableAttributedString(string: mainString)
        myString.setAttributes(textAttributes as? [NSAttributedStringKey : Any], range: range)
        return myString
    }
    
    func getLabelForFontAwesomeForRequestParam() -> UILabel {
        let lblEmpty = UILabel(frame: CGRect(x: CGFloat(kPlaceholderLeftPadding), y: CGFloat(kPlaceholderTopPadding), width: CGFloat(frame.width - kPlaceholderRightPadding - kPlaceholderLeftPadding), height: CGFloat(frame.height - kPlaceholderBottomPadding)))
        lblEmpty.numberOfLines = 2
        lblEmpty.textAlignment = .center
        lblEmpty.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblEmpty.font = THEME_FONT_REGULAR(size: 14.0)
        lblEmpty.sizeThatFits(lblEmpty.frame.size)
        return lblEmpty
    }
    
    
    func reloadData(withPlaceholderImage placeholderImage: UIImage?) {
        backgroundView = nil
        if numberOfSections == 0 || (numberOfItems(inSection: 0) == 0 || numberOfItems(inSection: 0) == NSNotFound) {
            if placeholderImage != nil {
                let img = UIImageView(frame: frame)
                img.image = placeholderImage
                img.backgroundColor = UIColor.clear
                img.contentMode = .scaleAspectFit
                backgroundView = img
            }
        }
        else {
            backgroundView = nil
        }
        reloadData()
    }
    
}
