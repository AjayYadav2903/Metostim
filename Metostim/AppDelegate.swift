//
//  AppDelegate.swift
//  Fingerprint
//
//  Created by admin on 02/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var drawerContainer: MMDrawerController?
    var buildVersion = ""
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared().isEnabled = true
        if let text = Bundle.main.infoDictionary?["CFBundleVersion"]  as? String {
            buildVersion = text
            if UserDefaults.standard.string(forKey: "version") != nil{
                let str = UserDefaults.standard.string(forKey: "version")
                if Float(str!)! != Float(buildVersion)!{
                    UserDefaults.standard.set(text, forKey: "version")
                    if AccountInfo.shared.getToken() != "" {
                        openDashBoard()
                    }else {
                        //loginFirebase()
                        moveToIntroView()
                    }
                    
                }
                else{
                    loginFirebase()
                }
            }else{
               // UserDefaults.standard.set(text, forKey: "version")
               // moveToIntroView()
                
                if AccountInfo.shared.getToken() != "" {
                    openDashBoard()
                }else {
                    //loginFirebase()
                    moveToIntroView()
                }
            }
        }
        return true
    }
    
    func moveToIntroView()
    {
        let login : IntroViewVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "IntroViewVC") as! IntroViewVC
        let nav: UINavigationController = UINavigationController(rootViewController: login)
        nav.isNavigationBarHidden=true
        self.window?.rootViewController = nav
    }
    
    func loginFirebase()  {
      
            let loginStoryBoard = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            let loginVC = loginStoryBoard
            let navi = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navi
    }
    
    func openDashBoard()  {
      
            let loginStoryBoard = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
            let loginVC = loginStoryBoard
            let navi = UINavigationController(rootViewController: loginVC)
            window?.rootViewController = navi
    }
    
    func welcomeName() {
        
    }
    
    func logOut(){
     
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let navi = UINavigationController(rootViewController: self.getStartVC())
            appDelegate.window?.rootViewController = navi
    }
    
    func getStartVC() -> UIViewController {
        let mainStoryboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        return mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
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
        drawerContainer = MMDrawerController(center: centerNavigation, leftDrawerViewController: leftSideMenuNav)
        // app.mainNav = mainNavigationController
        drawerContainer?.showsShadow = true
        
        drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
        drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        drawerContainer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningNavigationBar
        drawerContainer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        drawerContainer?.closeDrawerGestureModeMask = .tapCenterView
        drawerContainer?.closeDrawerGestureModeMask = .all
        // Assign MMDrawerController to our window's root ViewController
        
        UIApplication.shared.windows.first?.rootViewController = drawerContainer
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

