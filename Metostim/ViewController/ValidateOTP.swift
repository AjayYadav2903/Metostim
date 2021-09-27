//
//  ValidateOTP.swift
//  Vridhisoftech
//
//  Created by Ajay Yadav on 24/09/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import KRProgressHUD
import NVActivityIndicatorView

class ValidateOTP: UIViewController,NVActivityIndicatorViewable  {

    var isComeFromForgetPass = false
    
    // connect the textfields outlets
       @IBOutlet weak var firstDigitField: SingleDigitField!
       @IBOutlet weak var secondDigitField: SingleDigitField!
       @IBOutlet weak var thirdDigitField: SingleDigitField!
       @IBOutlet weak var fourthDigitField: SingleDigitField!
       @IBOutlet weak var fifthDigitField: SingleDigitField!
       @IBOutlet weak var sixDigitField: SingleDigitField!
    
    @IBOutlet weak var btnVerifyOTP: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // add a target for editing changed for each field
              [firstDigitField,secondDigitField,thirdDigitField,fourthDigitField,fifthDigitField,sixDigitField].forEach {
                  $0?.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
              }
              // make the firsDigitField the first responder
              firstDigitField.isUserInteractionEnabled = true
              firstDigitField.becomeFirstResponder()
        setUpUI()
    }
    
    // here you control what happens to each change that occurs to the fields
      @objc func editingChanged(_ textField: SingleDigitField) {
          // check if the deleteBackwards key was pressed
          if textField.pressedDelete {
              // reset its state
              textField.pressedDelete = false
              // if the field has text empty its content
              if textField.hasText {
                  textField.text = ""
              } else {
                  // otherwise switch the field, resign the first responder and activate the previous field and empty its contents
                  switch textField {
                  case secondDigitField, thirdDigitField, fourthDigitField,fifthDigitField,sixDigitField:
                      textField.resignFirstResponder()
                      textField.isUserInteractionEnabled = false
                      switch textField {
                      case secondDigitField:
                          firstDigitField.isUserInteractionEnabled = true
                          firstDigitField.becomeFirstResponder()
                          firstDigitField.text = ""
                      case thirdDigitField:
                          secondDigitField.isUserInteractionEnabled = true
                          secondDigitField.becomeFirstResponder()
                          secondDigitField.text = ""
                      case fourthDigitField:
                          thirdDigitField.isUserInteractionEnabled = true
                          thirdDigitField.becomeFirstResponder()
                          thirdDigitField.text = ""
                      case fifthDigitField:
                          fourthDigitField.isUserInteractionEnabled = true
                        fourthDigitField.becomeFirstResponder()
                        fourthDigitField.text = ""
                      case sixDigitField:
                          fifthDigitField.isUserInteractionEnabled = true
                        fifthDigitField.becomeFirstResponder()
                        fifthDigitField.text = ""
                      default:
                          break
                      }
                  default: break
                  }
              }
          }
          // make sure there is only one character and it is a number otherwise delete its contents
          guard textField.text?.count == 1, textField.text?.last?.isWholeNumber == true else {
              textField.text = ""
              return
          }
          // switch the textField, resign the first responder and make the next field active
          switch textField {
          case firstDigitField, secondDigitField, thirdDigitField,fourthDigitField,fifthDigitField:
              textField.resignFirstResponder()
              textField.isUserInteractionEnabled = false
              switch textField {
              case firstDigitField:
                  secondDigitField.isUserInteractionEnabled = true
                  secondDigitField.becomeFirstResponder()
              case secondDigitField:
                  thirdDigitField.isUserInteractionEnabled = true
                  thirdDigitField.becomeFirstResponder()
              case thirdDigitField:
                  fourthDigitField.isUserInteractionEnabled = true
                  fourthDigitField.becomeFirstResponder()
              case fourthDigitField:
                  fifthDigitField.isUserInteractionEnabled = true
                  fifthDigitField.becomeFirstResponder()
              case fifthDigitField:
                  sixDigitField.isUserInteractionEnabled = true
                  sixDigitField.becomeFirstResponder()
              default: break
              }
          case sixDigitField:
              sixDigitField.resignFirstResponder()
          default: break
          }
      }
    
    func setUpUI()  {
        
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.navigationBar.barTintColor = UIColor.clear
        
        
        btnVerifyOTP.cornerRadius = btnVerifyOTP.frame.size.height/2
    }
    

    
    @IBAction func btnActionVerify(_ sender: UIButton) {
        let otpAll = "\(firstDigitField.text ?? "")\(secondDigitField.text ?? "")\(thirdDigitField.text ?? "")\(fourthDigitField.text ?? "")\(fifthDigitField.text ?? "")\(sixDigitField.text ?? "")"
        
        if String(AccountInfo.shared.Otp ?? 0) == otpAll {
            serverCommunication()
        }else {
            Utils.showAlert(title: "", msg: "Please enter the correct OTP", selfObj: self) {
                
            }
        }
    }
    
    @IBAction func btnActionResendOTP(_ sender: UIButton) {
        serverCommunicationResendOTP()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ValidateOTP {
    
    func serverCommunicationResendOTP()  {
        let loginDicParametrs = NSMutableDictionary()
        let mobNum = Int(AccountInfo.shared.getPhone())
        
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
                if message != nil && message != "" {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                    })
                    return
                }
             
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
    
    
}

extension ValidateOTP {
    func serverCommunication()  {
        let loginDicParametrs = NSMutableDictionary()

        loginDicParametrs.setObject(AccountInfo.shared.userID ?? 0, forKey:AuthonticationValidateOTP.kUserID as NSString)
        loginDicParametrs.setObject(AccountInfo.shared.Otp ?? 0, forKey:AuthonticationValidateOTP.kOTP as NSString)


        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.stopAnimating(nil)
        }

        WebServices.PostRequest(urlApiString: Metostim.Server.BaseUrl + Metostim.Server.ValidateOTP, paramters: loginDicParametrs as! [String : AnyObject],showProgress: true) {[weak self] (json, message, status) in
            guard let owner = self else {return}
            if status == true{

                if json["Token"]["Errormessage"].string != "" && json["Token"]["Errormessage"].string != nil {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: json["Token"]["Errormessage"].string ?? "", strTitle: "Alert")
                    })
                    return
                }
                if json["data"] == true {
                    if self?.isComeFromForgetPass == true {
                        let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                        self?.navigationController?.pushViewController(loginStoryBoard, animated: true)
                    }else {
                        let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
                        self?.navigationController?.pushViewController(loginStoryBoard, animated: true)
                    }
                }else {
                    if message != nil && message != "" {
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                        })
                        return
                    }
                }
            } else {
                KRProgressHUD.dismiss({
                    PopupConfirmCommon.showRequestPopup(strMgs: message ?? "", strTitle: "Alert")
                })
            }
        }
    }
}


class SingleDigitField: UITextField {
    // create a boolean property to hold the deleteBackward info
    var pressedDelete = false
    // customize the text field as you wish
    override func willMove(toSuperview newSuperview: UIView?) {
        keyboardType = .numberPad
        textAlignment = .center
        backgroundColor = .white
        isSecureTextEntry = false
        isUserInteractionEnabled = false
    }
    // hide cursor
    override func caretRect(for position: UITextPosition) -> CGRect { .zero }
    // hide selection
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] { [] }
    // disable copy paste
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool { false }
    // override deleteBackward method, set the property value to true and send an action for editingChanged
    override func deleteBackward() {
        pressedDelete = true
        sendActions(for: .editingChanged)
    }
}
