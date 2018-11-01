//
//  LoginAppVC.swift
//  App
//
//  Created by Qwesys on 01/11/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit

class LoginAppVC: BaseVC {
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var vwInner: UIView!
    
    
    let yourAttributes : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
        NSAttributedStringKey.foregroundColor : UIColor.darkGray,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    let yourAttributes2 : [NSAttributedStringKey: Any] = [
        NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),
        NSAttributedStringKey.foregroundColor : UIColor.darkGray,
        NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
    
    var attributedString = NSMutableAttributedString(string:"")
    var attributedString2 = NSMutableAttributedString(string:"")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Email Address",
                                                            attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password",
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        self.vwInner.setCornerRadius(radius: 5.0)
        // Do any additional setup after loading the view.
        
        let buttonTitleStr = NSMutableAttributedString(string:"New here? Sign Up", attributes:yourAttributes as [NSAttributedStringKey : Any])
        attributedString.append(buttonTitleStr)
        btnSignUp.setAttributedTitle(attributedString, for: .normal)
        
        
        let buttonTitleStr2 = NSMutableAttributedString(string:"Forgot password?", attributes:yourAttributes2 as [NSAttributedStringKey : Any])
        attributedString2.append(buttonTitleStr2)
        btnForgot.setAttributedTitle(attributedString2, for: .normal)
        
        
        self.btnSignin.addBorder(edges: .bottom, color: APP_GREEN_BORDER_COLOR, thickness: 5.0)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    self.navigationController?.navigationBar.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: -  Button Action
    
    @IBAction func clickOnSkip(_ sender: Any) {
        self.navigationController?.navigationBar.isHidden = false
        let homeVC = loadVC(storyboardMain, viewHomeAppVC) as! HomeAppVC
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    @IBAction func clickOnForgotPassword(_ sender: Any) {
        showAlertWithTitleWithMessage(message: "Work in progress")
    }
    
    @IBAction func clickOnSignUp(_ sender: Any) {
        showAlertWithTitleWithMessage(message: "Work in progress")
    }
    @IBAction func clickOnSigIn(_ sender: Any) {
        if self.txtEmail.text == ""{
            showAlertWithTitleWithMessage(message: "Please enter email id")
        }else{
            if HelperFunction.helper.isValidEmail(testStr: self.txtEmail.text!){
                if self.txtPassword.text == ""{
                    showAlertWithTitleWithMessage(message: "Please enter password")
                }else{
                    self.getAuthentication()
                }
            }else{
                showAlertWithTitleWithMessage(message: "Please enter valid email id")
            }
        }
        
    }
    //MARK: - custom method
    
    //check user is valid or not
    func getAuthentication(){
        
        if isConnectedToNetwork() {
            
            self.createMainLoaderInView(message: "Loading...")
            let dic = ["txtusername" : "1aa28",
                       "txtpassword":"vaapglkns",
                       "txtdeviceid":"54554sd45s4d5cvsd",
                       "txtdevicetype":"1"]
            
            let urlSignIn = "http://192.168.0.204/old_projects/mogambo/api/login.php"
            HttpRequestManager.sharedInstance.postParameterRequest(endpointurl: urlSignIn, reqParameters: dic as NSDictionary) { (responseDic, error, message, true) in
                self.stopLoaderAnimation(vc: self)
                DLog(responseDic)
                if let strMsg:String = responseDic!["Message"] as? String{
                    self.stopLoaderAnimation(vc: self)
                    showAlertWithTitleWithMessage(message: strMsg)
                }else{
                    self.stopLoaderAnimation(vc: self)
                    showAlertWithTitleWithMessage(message: SOMETHING_WRONG)
                }
                
            }
        }else{
            showAlertWithTitleWithMessage(message: "No Internet Connection")
        }
    }
    
}
