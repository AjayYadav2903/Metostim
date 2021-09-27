//
//  SignUpConfirmation.swift
//  Fingerprint
//
//  Created by admin on 03/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SignUpConfirmation: UIViewController {

    @IBOutlet weak var btnLoginNow: UIButton!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userName : String!
    var password : String!


    override func viewDidLoad() {
        super.viewDidLoad()
        btnLoginNow.cornerRadius = btnLoginNow.frame.size.height/2

    }
 
    @IBAction func btnActionLoginNow(_ sender: UIButton) {
              login()
       }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func login() {
        
    }
    
    func buildNavigationDrawer()
    {
        let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
        let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
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
