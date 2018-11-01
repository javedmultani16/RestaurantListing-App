//
//  BaseVC.swift
//  iOS
//
//  Created by Javed Multani on 24/07/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftIcons

class BaseVC: UIViewController , UIGestureRecognizerDelegate , NVActivityIndicatorViewable{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    //MARK:
    //MARK: NavigationBar set
    
    func imageFromView(view: UIView) -> UIImage {
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func setNavigationbarleft_imagename(left_icon_Name: IoniconsType?,
                                        left_imagename: String? = nil,
                                        left_String: String? = nil,
                                        left_action: Selector?,
                                        right_icon_Name: IoniconsType?,
                                        right_String: String? = nil,
                                        right_action: Selector?,
                                        title: String?,
                                        withThemeImageName: String? = nil,
                                        is_back: Bool = false) {
        
        self.navigationController?.setNavigationBarHidden (false, animated: false)
        //        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        //        self.navigationController?.navigationBar.barTintColor = APP_THEME_COLOR
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        
        let myView = HorizontalGradientView.init(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH(), height: 64),
                                                 leftColor: APP_THEME_COLOR, rightColor: APP_THEME_COLOR2)
        myView.leftColor = APP_THEME_COLOR
        myView.rightColor = APP_THEME_COLOR2
        let img = imageFromView(view: myView)
        self.navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        //.setBackgroundImage(self.gradientLayerImage(), for: .default)
        
        if (left_imagename?.length != 0 || left_String != nil || left_icon_Name != nil)
        {
            let btnleft: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: (left_String != nil ? 60 : 30), height: 35))
            btnleft.layer.cornerRadius = btnleft.frame.width/2
            btnleft.setTitleColor(APP_WHITE_COLOR, for: .normal)
            
            if left_String != nil {
                btnleft.setTitle(left_String, for: .normal)
                btnleft.addTarget(self, action: left_action!, for: .touchDown)
            }
            else{
                btnleft.titleLabel!.numberOfLines = 0
                if left_icon_Name != nil{
                    if !is_back{
                        btnleft.addTarget(self, action: left_action!, for: .touchDown)
                        btnleft.setIcon(icon: .ionicons(left_icon_Name!), iconSize : 22, color : APP_WHITE_COLOR, forState: .normal)
                    }
                    else{
                        btnleft.addTarget(self, action: #selector(btnBackHandle(_:)), for: .touchUpInside)
                        btnleft.setIcon(icon: .ionicons(.iosArrowBack), iconSize : 22, color : APP_WHITE_COLOR, forState: .normal)
                    }
                }
            }
            
            btnleft.titleLabel!.textAlignment = .left
            
            let backBarButon: UIBarButtonItem = UIBarButtonItem(customView: btnleft)
            self.navigationItem.setLeftBarButton(backBarButon, animated: false)
        }
        else
        {
            self.navigationItem.hidesBackButton = true;
            self.navigationItem.leftBarButtonItem = nil;
        }
        
        if (right_icon_Name != nil || right_String != nil)
        {
            let btnright: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: (right_String != nil ? 60 : 30), height: 35))
            btnright.layer.cornerRadius = btnright.frame.width/2
            btnright.setTitleColor(APP_WHITE_COLOR, for: .normal)
            btnright.titleLabel?.font = THEME_FONT_MEDIUM(size: 13)
            if right_icon_Name != nil {
                btnright.titleLabel!.numberOfLines = 0
                btnright.setIcon(icon: .ionicons(right_icon_Name!), iconSize : 22, color : APP_WHITE_COLOR, forState: .normal)
            }
            else if right_String != nil{
                btnright.setTitle(right_String, for: .normal)
            }
            
            btnright.addTarget(self, action: right_action!, for: .touchDown)
            btnright.titleLabel!.textAlignment = .right
            
            let backBarButon: UIBarButtonItem = UIBarButtonItem(customView: btnright)
            self.navigationItem.setRightBarButton(backBarButon, animated: false)
        }
        else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
        
        if (title?.length)! > 0 {
            
            let lblValues: UILabel = UILabel()
            lblValues.text = title
            lblValues.clipsToBounds = false
            lblValues.backgroundColor = CLEAR_COLOR
            lblValues.textColor = APP_WHITE_COLOR
            lblValues.sizeToFit()
            lblValues.tag = 1212
            lblValues.textAlignment = .center;
            lblValues.font = THEME_FONT_BOLD(size: 16);
            self.navigationItem.titleView = lblValues
        }
        
        if withThemeImageName != nil{
            
            let titleImage:UIImage = Set_Local_Image(withThemeImageName!)
            let titleView:UIImageView = UIImageView(image: titleImage)
            titleView.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
            titleView.image = titleView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            titleView.contentMode = .scaleAspectFit
            titleView.tintColor = APP_WHITE_COLOR
            self.navigationItem.titleView = titleView
        }
        
    }
    
    func setNavigationbar(isMenu : Bool = true,
                          isBack : Bool = false,
                          right_icon_Name: FASolidType?,
                          right_String: String? = nil,
                          right_action: Selector?,
                          title: String?,
                          withThemeImageName: String? = nil) {
        
        self.navigationController?.setNavigationBarHidden (false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = APP_THEME_COLOR
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        
        let btnleft = UIButton(type: .custom)
        btnleft.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnleft.layer.cornerRadius = btnleft.frame.width/2
        if isBack{
            btnleft.addTarget(self, action: #selector(btnBackHandle(_:)), for: .touchUpInside)
            btnleft.setIcon(icon: .ionicons(.androidArrowBack), iconSize : 22, color : APP_WHITE_COLOR, forState: .normal)
        }
        else{
        }
        btnleft.titleLabel!.textAlignment = .left
        let backBarButon: UIBarButtonItem = UIBarButtonItem(customView: btnleft)
        
        let btnMenu = UIButton(type: .custom)
        btnMenu.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnMenu.layer.cornerRadius = btnleft.frame.width/2
       // btnMenu.addTarget(self, action: #selector(buttonHandlerMenu(_:)), for: .touchUpInside)
        btnMenu.setIcon(icon: .ionicons(.androidMenu), iconSize : 25, color : APP_WHITE_COLOR, forState: .normal)
        btnMenu.titleLabel!.textAlignment = .left
        let backBarButon2: UIBarButtonItem = UIBarButtonItem(customView: btnMenu)
        
        self.navigationItem.leftBarButtonItems = [backBarButon2, backBarButon]
        
        //        self.navigationItem.setLeftBarButton(backBarButon, animated: false)
        
        /*if (right_icon_Name != nil || right_String != nil)
         {
         let btnright: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: (right_String != nil ? 60 : 30), height: 35))
         btnright.layer.cornerRadius = btnright.frame.width/2
         btnright.setTitleColor(APP_WHITE_COLOR, for: .normal)
         btnright.titleLabel?.font = THEME_FONT_MEDIUM(size: 13)
         if right_icon_Name != nil {
         btnright.titleLabel!.numberOfLines = 0
         btnright.setIcon(icon: .ionicons(right_icon_Name!), iconSize : 22, color : APP_WHITE_COLOR, forState: .normal)
         }
         else if right_String != nil{
         btnright.setTitle(right_String, for: .normal)
         }
         
         btnright.addTarget(self, action: right_action!, for: .touchDown)
         btnright.titleLabel!.textAlignment = .right
         
         let backBarButon: UIBarButtonItem = UIBarButtonItem(customView: btnright)
         self.navigationItem.setRightBarButton(backBarButon, animated: false)
         }
         else
         {
         self.navigationItem.rightBarButtonItem = nil;
         }
         */
        
        let btnright = UIButton(type: .custom)
        btnright.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        btnright.layer.cornerRadius = btnleft.frame.width/2
        btnright.setImage(Set_Local_Image("smallLogo"), for: .normal)
        btnright.imageView?.contentMode = .scaleAspectFit
        btnright.titleLabel!.textAlignment = .left
        let backRightBarButon1: UIBarButtonItem = UIBarButtonItem(customView: btnright)
        
        if right_icon_Name != nil {
            let btnRight1 = UIButton(type: .custom)
            btnRight1.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            btnRight1.layer.cornerRadius = btnleft.frame.width/2
            btnRight1.addTarget(self, action: right_action!, for: .touchDown)
            //btnRight1.setIcon(icon: .fontAwesomeSolid(right_icon_Name!), iconSize : 22, color : APP_WHITE_COLOR, forState: .normal)
            btnRight1.setImage(Set_Local_Image("ic_filter"), for: .normal)
            let backRightBarButon2: UIBarButtonItem = UIBarButtonItem(customView: btnRight1)
            self.navigationItem.rightBarButtonItems = [backRightBarButon1,backRightBarButon2]
        }
        else{
            self.navigationItem.rightBarButtonItems = [backRightBarButon1]
        }
        
        
        
        if (title?.length)! > 0 {
            
            let lblValues: UILabel = UILabel()
            lblValues.text = title
            lblValues.clipsToBounds = false
            lblValues.backgroundColor = CLEAR_COLOR
            lblValues.textColor = APP_WHITE_COLOR
            lblValues.sizeToFit()
            lblValues.tag = 1212
            lblValues.textAlignment = .center;
            lblValues.font = THEME_FONT_BOLD(size: 16);
            self.navigationItem.titleView = lblValues
        }
        
        if withThemeImageName != nil{
            
            let titleImage:UIImage = Set_Local_Image(withThemeImageName!)
            let titleView:UIImageView = UIImageView(image: titleImage)
            titleView.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
            titleView.image = titleView.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            titleView.contentMode = .scaleAspectFit
            titleView.tintColor = APP_WHITE_COLOR
            self.navigationItem.titleView = titleView
        }
        
    }
    
    @IBAction func btnBackHandle(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: - Loader Methods
    func createMainLoaderInView(message : String) {
        runOnMainThread {
            let size = CGSize(width: 60, height: 60)
            self.startAnimating(size, message: message, type: .ballSpinFadeLoader)//ballClipRotatePulse
        }
    }
    
    
    func stopLoaderAnimation(vc : UIViewController) {
        runOnMainThread {
            self.stopAnimating()
        }
    }
    
    
}
