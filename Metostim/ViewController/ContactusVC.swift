//
//  ContactusVC.swift
//  Fingerprint
//
//  Created by admin on 14/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ContactusVC: UIViewController {

    @IBOutlet weak var lblContact : UILabel!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        lblContact.text = Constant.StringMsg.contact
           self.navigationController?.isNavigationBarHidden = true
       }
       
       @IBAction func btnActionDrawer(_ sender: UIButton) {
            toggleLeftSlide()
          }
       
       @IBAction func btnActionStepsHere(_ sender: UIButton) {
       }
       
       func toggleLeftSlide(){
              let appDelegate = UIApplication.shared.delegate as! AppDelegate
              appDelegate.drawerContainer?.toggle(MMDrawerSide.left, animated: true, completion: nil)
          }

}
