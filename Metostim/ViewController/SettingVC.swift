//
//  SettingVC.swift
//  Fingerprint
//
//  Created by admin on 10/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()
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
