//
//  SignUpSelectAccountVC.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SignUpSelectAccountVC: UIViewController {
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var imgCustomer: UIImageView!
    @IBOutlet weak var imgAgency: UIImageView!

    var accountType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnNext.cornerRadius = btnNext.frame.size.height/2

    }
    
    @IBAction func btnActionCustomer(_ sender: UIButton) {
        accountType = Constant.accountType.Customer
        imgCustomer.backgroundColor = UIColor.lightGray
        imgAgency.backgroundColor = UIColor.clear
    }
    
    @IBAction func btnActionAgency(_ sender: UIButton) {
        accountType = Constant.accountType.Agency
        imgCustomer.backgroundColor = UIColor.clear
        imgAgency.backgroundColor = UIColor.lightGray
    }
    
    @IBAction func btnActionNext(_ sender: UIButton) {
        if accountType != "" {
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            loginStoryBoard.accountType = accountType
            self.navigationController?.pushViewController(loginStoryBoard, animated: true)
        }else {
            Utils.showAlert(title: "", msg: "You should tap to choose your account type", selfObj: self) {
                
            }
        }


    }
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
