//
//  Utils.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Utils: NSObject {
    
    private static var vSpinner : UIView?

  static func isValidEmail(Emailid:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: Emailid)
   }
    
    static func isValidPassword(Password:String?) -> Bool {
        guard Password != nil else { return false }

        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: Password)
    }

 
    static func showAlert(title:String,msg:String,selfObj:UIViewController,completionBlock : @escaping()-> Void)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alert) in
            completionBlock()
        }))

        // alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        selfObj.present(alert, animated: true)
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func randomNumbers(length: Int) -> String {
          let letters = "0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
      }
    
    static func reportIDUDIDumbers() -> String {
            let uuid = UUID().uuidString
            return uuid
        }
    
    public static func showLoader(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .clear
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        vSpinner = spinnerView
        vSpinner?.tag = 112233
    }

    public static func removeLoader() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
    public static func changePlaceholderColor(txtFld:UITextField,text:String) {
        txtFld.attributedPlaceholder = NSAttributedString(string: text,
       attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
   public static func readJsonFromFile(completion : @escaping (_ jsonData : JSON?)-> Void)  {

    let filePath = Bundle.main.path(forResource: "SideMenuItems", ofType: "json", inDirectory: nil)

        if let filePath = filePath {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let json = try? JSONSerialization.jsonObject(with: jsonData)
            } catch {
                print(error)
                fatalError("Unable to read contents of the file url")
            }
        }
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
