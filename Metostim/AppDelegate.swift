//
//  AppDelegate.swift
//  Fingerprint
//
//  Created by admin on 02/06/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import IQKeyboardManager
import CoreData

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

    func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    self.saveContext()
    }
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
    /*
    The persistent container for the application. This implementation
    creates and returns a container, having loaded the store for the
    application to it. This property is optional since there are legitimate
    error conditions that could cause the creation of the store to fail.
    */
    let container = NSPersistentContainer(name: "Metostim")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
    if let error = error as NSError? {
    // Replace this implementation with code to handle the error appropriately.
    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    /*
    Typical reasons for an error here include:
    * The parent directory does not exist, cannot be created, or disallows writing.
    * The persistent store is not accessible, due to permissions or data protection when the device is locked.
    * The device is out of space.
    * The store could not be migrated to the current model version.
    Check the error message to determine what the actual problem was.
    */
    fatalError("Unresolved error \(error), \(error.userInfo)")
    }
    })
    return container
    }()
    // MARK: - Core Data Saving support
    func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
    do {
    try context.save()
    } catch {
    // Replace this implementation with code to handle the error appropriately.
    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    let nserror = error as NSError
    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
    }
    }
    
}

