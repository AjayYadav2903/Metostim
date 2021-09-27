//
//  ChangePasswordVC.swift
//  Vridhisoftech
//
//  Created by Ajay Yadav on 26/09/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD
import NVActivityIndicatorView

class ChangePasswordVC: UIViewController,NVActivityIndicatorViewable  {

    @IBOutlet weak var txtFldPassword : UITextField!
    @IBOutlet weak var txtFldConfirmPassword : UITextField!


    @IBOutlet weak var btnResetPassword: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI()  {
        
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor.clear
        
        txtFldPassword.setIconOnTextFieldLeft(UIImage(named: "email")!)
        txtFldConfirmPassword.setIconOnTextFieldLeft(UIImage(named: "email")!)

        btnResetPassword.cornerRadius = btnResetPassword.frame.size.height/2
        
        Utils.changePlaceholderColor(txtFld: txtFldPassword, text: "Enter your Mobile number")
        Utils.changePlaceholderColor(txtFld: txtFldConfirmPassword, text: "Enter your Mobile number")

    }
    
    @IBAction func btnActionResetPassword(_ sender: UIButton) {
        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ValidateOTP") as! ValidateOTP
        self.navigationController?.pushViewController(loginStoryBoard, animated: true)
        
        
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ChangePasswordVC {
    
    func serverCommunication()  {
        let loginDicParametrs = NSMutableDictionary()
        loginDicParametrs.setObject(AccountInfo.shared.userID ?? 0, forKey:AuthonticationChangePassword.kUserID as NSString)
        loginDicParametrs.setObject(txtFldPassword.text ?? "", forKey:AuthonticationChangePassword.kUserPassword as NSString)


        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating(nil)
        }

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.ChangePassword, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true{
                if json["Token"]["Errormessage"].string != "" && json["Token"]["Errormessage"].string != nil{
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
                if json["data"] == true {
                    let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                    self?.navigationController?.pushViewController(loginStoryBoard, animated: true)
                }
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
    
    
}
