//
//  LoginVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import KRProgressHUD
import NVActivityIndicatorView

class LoginVC: UIViewController,NVActivityIndicatorViewable  {
    
    @IBOutlet weak var lblWelcomeMsg : UILabel!
    @IBOutlet weak var txtFldName : UITextField!
    @IBOutlet weak var txtFldPassword : UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnLogin : UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        lblWelcomeMsg.text = Constant.StringMsg.welcome
    }
    
    func setUpUI()  {
        self.navigationController?.isNavigationBarHidden = true
        txtFldName.cornerRadius = txtFldName.frame.size.height/2
        txtFldPassword.cornerRadius = txtFldName.frame.size.height/2
        btnSignUp.cornerRadius = txtFldName.frame.size.height/2
        btnLogin.cornerRadius = txtFldName.frame.size.height/2
        txtFldName.setIconOnTextFieldLeft(UIImage(named: "person")!)
        txtFldPassword.setIconOnTextFieldLeft(UIImage(named: "key")!)
        Utils.changePlaceholderColor(txtFld: txtFldPassword, text: "Enter your passwprd")
        Utils.changePlaceholderColor(txtFld: txtFldName, text: "Enter your Mobile number")
    }    
    
    @IBAction func btnActionSignUp(_ sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
    }
    
    @IBAction func btnActionLogin(_ sender: UIButton) {
        if txtFldName.text == "" {
            
            Utils.showAlert(title: "", msg: "Please enter mobile number", selfObj: self) {
                
            }
            return
        }
        if txtFldName.text?.count ?? 0 < 10{
            
            Utils.showAlert(title: "", msg: "Please enter correct mobile number", selfObj: self) {
                
            }
            return
        }
        if txtFldPassword.text == "" {
            
            Utils.showAlert(title: "", msg: "Please enter password", selfObj: self) {
                
            }
            return
        }
        serverCommunication()
    }
    
    @IBAction func btnActionForgetPassword(_sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ForgetPassVC") as! ForgetPassVC
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
    }
    
    func buildNavigationDrawer()
    {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
        var mainNavigationController = UIViewController()
        
        mainNavigationController =  mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
       
        let leftSideMenu : LeftSlideViewController = UIStoryboard(name: "Leftmenu", bundle: nil).instantiateViewController(withIdentifier: "LeftSlideViewController") as! LeftSlideViewController
        
        
        // Wrap into Navigation controllers
        let leftSideMenuNav = UINavigationController(rootViewController:leftSideMenu)
        let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
        
        // Cerate MMDrawerController
        //drawerContainer = MMDrawerController(center: mainPage, leftDrawerViewController: leftSideMenuNav)
        appDelegate.drawerContainer = MMDrawerController(center: centerNavigation, leftDrawerViewController: leftSideMenuNav)
        // app.mainNav = mainNavigationController
        appDelegate.drawerContainer?.showsShadow = true
        
        appDelegate.drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
        appDelegate.drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        appDelegate.drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningNavigationBar
        appDelegate.drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        appDelegate.drawerContainer?.closeDrawerGestureModeMask = .tapCenterView
        appDelegate.drawerContainer?.closeDrawerGestureModeMask = .all
        // Assign MMDrawerController to our window's root ViewController
        
        UIApplication.shared.windows.first?.rootViewController = appDelegate.drawerContainer
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

extension LoginVC {
    
    func serverCommunication()  {
        let loginDicParametrs = NSMutableDictionary()
        let mobNum = Int(txtFldName.text ?? "0")
        
        loginDicParametrs.setObject(mobNum ?? 0, forKey:AuthonticationParams.kMobile as NSString)
        loginDicParametrs.setObject(txtFldPassword.text ?? "", forKey:AuthonticationParams.kPassword as NSString)


        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating(nil)
        }

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.LoginApi, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true{
                if json["Token"]["Errormessage"].string != "" && json["Token"]["Errormessage"].string != nil {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: json["Token"]["Errormessage"].string ?? "", strTitle: "Alert")
                    })
                    return
                }
                if message != nil && message != "" {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                    return
                }
                AccountInfo.shared.saveAccountInfo(json: json)
                let user = UserModel(json: json)
                AccountInfo.shared.saveUserModel(user: user)
                let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                self?.navigationController?.pushViewController(loginStoryBoard, animated: true)
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
    
    
}
