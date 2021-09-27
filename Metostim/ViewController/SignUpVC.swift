//
//  SignUpVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

import KRProgressHUD
import NVActivityIndicatorView

class SignUpVC: UIViewController,NVActivityIndicatorViewable  {
    @IBOutlet weak var txtFldName : UITextField!
    @IBOutlet weak var txtFldMobile : UITextField!
    @IBOutlet weak var txtFldEmail : UITextField!
    
    @IBOutlet weak var txtFldPassword : UITextField!
    @IBOutlet weak var txtFldConfirmPassword : UITextField!
    @IBOutlet weak var btnCountry : UIButton!

    var country : (String?,String?)!
    var arrCountry : [CountryData]?
    

    @IBOutlet weak var btnSignUp: UIButton!
    var accountType = "Customer"

    override func viewDidLoad() {
        super.viewDidLoad()
        getCountryCode()
        accountType = Constant.accountType.Customer
        setUpUI()
    }
    
    func setUpUI()  {
        
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor.clear

           txtFldName.setIconOnTextFieldLeft(UIImage(named: "person")!)
           txtFldMobile.setIconOnTextFieldLeft(UIImage(named: "iphone")!)
           txtFldEmail.setIconOnTextFieldLeft(UIImage(named: "mail")!)
        
           txtFldPassword.setIconOnTextFieldLeft(UIImage(named: "key")!)
           txtFldConfirmPassword.setIconOnTextFieldLeft(UIImage(named: "key")!)
        
        
        
           btnSignUp.cornerRadius = btnSignUp.frame.size.height/2
        
           Utils.changePlaceholderColor(txtFld: txtFldName, text: "Enter your name")
           Utils.changePlaceholderColor(txtFld: txtFldMobile, text: "Enter your mobile number")
           Utils.changePlaceholderColor(txtFld: txtFldEmail, text: "Enter your mail")
           Utils.changePlaceholderColor(txtFld: txtFldPassword, text: "Enter password")
           Utils.changePlaceholderColor(txtFld: txtFldConfirmPassword, text: "Enter confirm password")
        
      
       }
    
    
    func validatePassword() -> Bool {
        if txtFldPassword.text == "" {
            Utils.showAlert(title: "", msg: "Please enter password!", selfObj: self) {
                
            }
            return false
        }
        else if self.txtFldPassword.text?.count ?? 0 < 8{
            Utils.showAlert(title: "", msg: "Password must be greater than 8 characters", selfObj: self) {
                
            }
            return false
        }else if !Utils.isValidPassword(Password: txtFldPassword.text) {
            Utils.showAlert(title: "", msg: "password must contain uppercase lowercase and number", selfObj: self) {
                
            }
          return false
            
        }
        return true
    }
    
    @IBAction func btnActionSignUp(_ sender: UIButton) {
        if txtFldName.text! == "" {
            Utils.showAlert(title: "", msg: "Please enter your name", selfObj: self) {

            }
            return
        }
        
        if txtFldMobile.text! == "" {
            Utils.showAlert(title: "", msg: "Please enter your mobile number", selfObj: self) {

            }
            return
        }

        if Utils.isValidEmail(Emailid: txtFldEmail.text!) {

//            if !validatePassword() {
//
//            }else{
//
//            }
        }else {
            Utils.showAlert(title: "", msg: "please enter the valid email", selfObj: self) {

            }
            return
        }
        
        if txtFldPassword.text! == "" {
            Utils.showAlert(title: "", msg: "Please enter password", selfObj: self) {

            }
            return
        }
        
        if txtFldConfirmPassword.text! == "" {
            Utils.showAlert(title: "", msg: "Please enter confirm password", selfObj: self) {

            }
            return
        }
        
        if txtFldPassword.text! != txtFldConfirmPassword.text!  {
            Utils.showAlert(title: "", msg: "Password does not match", selfObj: self) {

            }
            return
        }
        
        if btnCountry.titleLabel?.text == ""  {
            Utils.showAlert(title: "", msg: "Please select country", selfObj: self) {

            }
            return
        }
        
        serverCommunication()
    }
    
    @IBAction func btnActionSignIn(_ sender: UIButton) {
    }
    
    @IBAction func btnActionGetCountryCode(_ sender: UIButton) {
        PopupSingleSelection.showRequestPopup(dataArr: arrCountry ?? [], strMgs: "", placeholder: "", strTitle: "Select Country", strActionTitle: "", isShowCloseButton: true, isRemoveAllSubview: false) { (val1, val2) in
            self.country = (val1,val2)
            self.btnCountry.setTitle(self.country.0, for: .normal)

        } rejectBlock: {
            
        }

    }
    
    @IBAction func btnActionSignIN(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SignUpVC {
    
    func getCountryCode()  {
        let loginDicParametrs = NSMutableDictionary()

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.GetCountry, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true{
                if message != nil && message != "" {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                    return
                }
                
                let countryData = try? JSONDecoder().decode(CountryModel.self, from: (json.rawData()))
                self?.arrCountry = countryData?.data
                self?.country = (self?.arrCountry?[0].countryName,self?.arrCountry?[0].countrycode)
                self?.btnCountry.setTitle(self?.country.0, for: .normal)
                
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
    
    func serverCommunication()  {
        let loginDicParametrs = NSMutableDictionary()
        let mobNum = Int(txtFldMobile.text ?? "0")
        let countryCode = Int(country.1 ?? "0")

        loginDicParametrs.setObject(txtFldName.text ?? "", forKey:AuthonticationParamsSignUp.kName as NSString)
        loginDicParametrs.setObject(mobNum ?? 0, forKey:AuthonticationParamsSignUp.kMobile as NSString)
        loginDicParametrs.setObject(txtFldEmail.text ?? "", forKey:AuthonticationParamsSignUp.kEmail as NSString)
        loginDicParametrs.setObject(txtFldPassword.text ?? "", forKey:AuthonticationParamsSignUp.kPassword as NSString)
        loginDicParametrs.setObject(country.0 ?? "", forKey:AuthonticationParamsSignUp.kCountry as NSString)
        loginDicParametrs.setObject(countryCode ?? 0, forKey:AuthonticationParamsSignUp.kCountryCode as NSString)


        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating(nil)
        }

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.Register, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
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


