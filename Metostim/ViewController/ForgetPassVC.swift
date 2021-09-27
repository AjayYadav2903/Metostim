//
//  ForgetPassVC.swift
//  Vridhisoftech
//
//  Created by Ajay Yadav on 24/09/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import UIKit
import KRProgressHUD
import NVActivityIndicatorView

class ForgetPassVC: UIViewController,NVActivityIndicatorViewable  {

    @IBOutlet weak var txtFldMobile : UITextField!



    @IBOutlet weak var btnSendOTP: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI()  {
        
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor.clear
        
        txtFldMobile.setIconOnTextFieldLeft(UIImage(named: "iphone")!)
        
        btnSendOTP.cornerRadius = btnSendOTP.frame.size.height/2
        
        Utils.changePlaceholderColor(txtFld: txtFldMobile, text: "Enter your Mobile number")
        
    }
 
    
    @IBAction func btnActionSendOTP(_ sender: UIButton) {
        
        if txtFldMobile.text != "" {
            serverCommunication()
        }else {
            if txtFldMobile.text == "" {
                Utils.showAlert(title: "", msg: "Please enter the mobile number", selfObj: self) {
                    
                }
                return
            }
        }
        
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ForgetPassVC {
    
    func serverCommunication()  {
        let loginDicParametrs = NSMutableDictionary()
        let mobNum = Int(txtFldMobile.text ?? "0")
        
        loginDicParametrs.setObject(mobNum ?? 0, forKey:AuthonticationForgetPassword.kMobileNo as NSString)


        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating(nil)
        }

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.ForgetPassword, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true{
                if json["Token"]["Errormessage"].string != "" && json["Token"]["Errormessage"].string != nil {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: json["Token"]["Errormessage"].string ?? "", strTitle: "Alert")
                    })
                    return
                }
                
                if json["Token"]["Msg"].string != "" && json["Token"]["Msg"].string != nil && json["Token"]["Msg"].string != "Sucess" {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: json["Token"]["Msg"].string ?? "", strTitle: "Alert")
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
                AccountInfo.shared.saveUserPhone(phone: self?.txtFldMobile.text ?? "0")
                let user = UserModel(json: json)
                AccountInfo.shared.saveUserModel(user: user)
                let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ValidateOTP") as! ValidateOTP
                loginStoryBoard.isComeFromForgetPass = true
                self?.navigationController?.pushViewController(loginStoryBoard, animated: true)
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
    
    
}
