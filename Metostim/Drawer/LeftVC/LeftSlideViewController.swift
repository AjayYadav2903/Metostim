//
//  LeftSlideViewController.swift
//  AirVting
//
//  Created by Admin on 6/21/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

enum LeftMenuCellType: String {
    case home = "Home"
    case fingerPrint = "About"
    case reports = "Cart"
    case contactUS = "Contact Us"
    case billing = "Wallet"
    case setting = "Settings"
    
    var iconName: String {
        get {
            switch self {
            case .home:
                return "home"
            case .fingerPrint:
                return "contactus"
            case .reports:
                return "contactus"
            case .contactUS:
                return "contactus"
            case .billing:
                return "contactus"
            case .setting:
                return "settings"
            }
        }
    }
}

enum LeftMenuAgencyCellType: String {
    case fingerPrint = "Recieved fingerprint"
    case reports = "Find Fingerprint"
    case contactUS = "Contact Us"
    case billing = "Billing"
    case setting = "Settings"
    
    var iconName: String {
        get {
            switch self {
            case .fingerPrint:
                return "submitfinger"
            case .reports:
                return "reports"
            case .contactUS:
                return "contactus"
            case .billing:
                return "billing"
            case .setting:
                return "settings"
            }
        }
    }
}



class LeftSlideViewController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbUsername: UILabel!
    @IBOutlet weak var lblagencyCode: UILabel!
    @IBOutlet weak var btnAgencyCode: UIButton!

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var displayNameLb: UILabel!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let itemsCandidate: [LeftMenuCellType] = [.home,.fingerPrint,.reports, .contactUS]
    let itemsAgency: [LeftMenuAgencyCellType] = [.fingerPrint,.reports, .contactUS]

    var cellOuterObjects = [OuterObject]()
    var cellInnerObjects = [InnerObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        var outer1 = OuterObject()
        outer1.open = false
        outer1.lblValue = "Home"
        outer1.iconName = "home"

        cellOuterObjects.append(outer1)
        
        let nib = UINib.init(nibName: Constant.nibName.leftSlideTableViewCell, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: Constant.cellIdentifier.cellLeftSlideReuseIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        tableView.estimatedRowHeight = 75
        
        tableView.rowHeight = UITableView.automaticDimension
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableMenu(_:)), name: Notification.Name(rawValue: "updateTableLeftMenu"), object: nil)
        readJsonMakeItems()
    }
    
    func readJsonMakeItems()  {
        
        Utils.readJsonFromFile { (json) in
            let sideMenuJson = try? JSONDecoder().decode(OuterObject.self, from: (json?.rawData())!)
            print(sideMenuJson?.iconName)

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        DispatchQueue.main.async {
            self.avatar.layer.cornerRadius = self.avatar.bounds.size.width / 2.0
            self.avatar.clipsToBounds = true
        }
        
      
        self.tableView.reloadData()
    }
    
    @objc func reloadTableMenu(_ notification: Notification) {
        tableView.reloadData()
    }
    
    @IBAction func btnCopyCode(_ sender: UIButton) {
        UIPasteboard.general.string = lblagencyCode.text
        let toast = Toast(text: "Acency code copied in clipboard")
        
        toast.show()
    }
    
    @IBAction func btnLogOut(_ sender: UIButton) {
        //        PopupConfirmCommon.showRequestPopup(strMgs: "log out question".localized, strTitle: "log out".localized, strActionTitle: "log out".localized, acceptBlock: {
        //            self.logOut()
        //            self.logOutFacebook()
        //        }, rejectBlock: nil)
        self.logOut()
    }
    
    @IBAction func didTouchGoToProfile(_ sender: Any) {
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
}

extension LeftSlideViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cellOuterObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier.cellLeftSlideReuseIdentifier) as! LeftSlideTableViewCell
            let cellType = cellOuterObjects[indexPath.row]
        cell.lblMenu.text = cellType.lblValue
            cell.imgMenu.image = UIImage(named: cellType.iconName)
            cell.selectionStyle = .none
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
            switch itemsCandidate[indexPath.row] {
            case .home:
//                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
//                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
//                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
//                appDelegate.drawerContainer?.centerViewController = centerNavigation
//                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
//                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                                
                
                if let object = cellOuterObjects[indexPath.row] as? OuterObject {
                    if(object.open == false){
                        var outer1 = OuterObject()
                        outer1.open = false
                        outer1.lblValue = "contactus"
                        outer1.iconName = "contactus"

                        cellOuterObjects.append(outer1)

                        //  data.insert(InnerObject(content: object.innerContent), atIndex: indexPath.row + 1)
                        tableView.beginUpdates()
                        tableView.insertRows(at: [(NSIndexPath(row: indexPath.row + 1, section: 0) as IndexPath)], with: .top)
                        tableView.endUpdates()
                    }else{
                        cellOuterObjects.remove(at: indexPath.row + 1)
                        tableView.beginUpdates()
                        tableView.deleteRows(at: [(NSIndexPath(row: indexPath.row + 1, section: 0) as IndexPath)], with: .top)
                        tableView.endUpdates()
                    }
                    object.open = !object.open
                }
                   
                
                
                
                
                
                
                
                
                
                

                break
            case .fingerPrint:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            case .reports:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeInfoVC") as! HomeInfoVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            case .contactUS:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "ContactusVC") as! ContactusVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            case .billing:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            case .setting:
                let mainStoryBoard:UIStoryboard = UIStoryboard(name:"Home", bundle:nil)
                let mainNavigationController = mainStoryBoard.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
                let centerNavigation = UINavigationController(rootViewController:mainNavigationController)
                appDelegate.drawerContainer?.centerViewController = centerNavigation
                appDelegate.drawerContainer?.navigationController?.isNavigationBarHidden = true
                appDelegate.drawerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
                break
            }
    }
}



