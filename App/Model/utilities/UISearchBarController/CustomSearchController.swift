//
//  CustomSearchController.swift
//  iOS
//
//  Created by Javed Multani on 23/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate {
    func didStartSearching()
    
    func didTapOnSearchButton()
    
    func didTapOnCancelButton()
    
    func didChangeSearchText(searchText: String)
}


class CustomSearchController: UISearchController, UISearchBarDelegate {
    
    var customSearchBar: CustomSearchBar!
    var customDelegate: CustomSearchControllerDelegate!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK:
    // MARK: Initialization
    
    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(frame: searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, bgColor: searchBarTintColor)
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
     // MARK:
    // MARK: Custom functions
    
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, bgColor: UIColor) {
        customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor)
        customSearchBar.barTintColor = bgColor
        customSearchBar.tintColor = textColor
        customSearchBar.showsBookmarkButton = false
        customSearchBar.showsCancelButton = false
        customSearchBar.delegate = self
    }
    
    
     // MARK:
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        customSearchBar.showsCancelButton = true
        customDelegate.didStartSearching()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.resignFirstResponder()
        customDelegate.didTapOnSearchButton()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar.showsCancelButton = false
        customSearchBar.resignFirstResponder()
        customDelegate.didTapOnCancelButton()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customDelegate.didChangeSearchText(searchText: searchText)
    }
    
}
