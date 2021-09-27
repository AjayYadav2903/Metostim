//
//  WebServices.swift
//  AirVting
//
//  Created by Admin on 7/13/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD

class WebServices: NSObject {
    
    static let sharedInstance = WebServices()
    public var backgroundSessionManager: Alamofire.SessionManager
    
    private override init() {
        backgroundSessionManager = Alamofire.SessionManager(configuration: URLSessionConfiguration.background(withIdentifier: "com.nexlesoft.AirVting2"))
    }
    
    //Use for sigin/signup
    class func PostRequest(urlApiString : String, paramters : [String:AnyObject], showProgress:Bool = true, completion : @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void){
        if showProgress {
            KRProgressHUD.show()
        }
        print("URL `==>>>>>> ", urlApiString)
        print("params ==>>>>>> ", paramters)
        
        let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
        print("Tokens ==>>>>>> ", (AccountInfo.shared.getToken()))
        Alamofire.request(urlApiString, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            
            print("URL ==>>>>>> ", urlApiString)
            print(response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        var status = true
                        if json["status"].exists() {
                            if json["status"].type == SwiftyJSON.Type.string {
                                if let value = json["status"].string {
                                    if value.uppercased() == "ok".uppercased() || value.uppercased() == "success".uppercased() {
                                        status = true
                                    }else {
                                        status = false
                                    }
                                }
                            }else {
                                if let value = json["status"].boolValue as? Bool {
                                    status = value 
                                }
                            }
                            
                        }
                        //json["status"].string ?? ""
                        let message = json["message"].string ?? ""
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "Alert", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    appDelegate.window?.rootViewController = startVC
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            if status == false {
                                print(message)
                                //                                KRProgressHUD.dismiss({
                                //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "Alert".localized)
                                //                                })
                            }
                        }
                    }catch {
                        print(error)
                        completion(JSON.null, error.localizedDescription, false)
                        KRProgressHUD.dismiss({
                            PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "Alert")
                        })
                    }
                }
                
                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 || error.code == -1005 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "Alert", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null,error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
    }
    
    
    
    
    
    class func getRequest(urlApiString : String, showProgress:Bool = false, language: String = "en", parameter: Parameters? = nil, completion : @escaping (_ jsonData : JSON, _ message: String?, _ success : Bool)-> Void){
        //        let header = ["Accept": "application/json",
        //                      "authorization": "Bearer \(AccountInfo.shared.getToken())",
        //            "language": "\(language)"]
        
        let header = ["Content-Type": "application/json","authorization": "Bearer \(AccountInfo.shared.getToken())"]
        if showProgress {
            KRProgressHUD.show()
        }
        print("____api response: \(urlApiString)")
        Alamofire.request(urlApiString, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: header).responseJSON { response in

            print("____api response: \(urlApiString): ", response)
            switch response.result {
            case .success:
                if let actualData = response.data {
                    do {
                        let json = try JSON(data: actualData)
                        let status = true//json["statusCode"].int == 201 ? true : false
                        let message = json["message"].string ?? ""
                        //Comment for test
                        if json["statusCode"].int == 401{
                            //                            showAlert(message: "Session expired, please login again".localized)
                            KRProgressHUD.dismiss({
                                PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "Alert", strActionTitle: nil, isShowCloseButton: false, isRemoveAllSubview: true, acceptBlock: {
                                    AccountInfo.shared.clearAccountInfo()
                                    //                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    //                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                    //                                    let startVC =  mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                                    //                                    appDelegate.window?.rootViewController = startVC
                                    
                                }, rejectBlock: nil)
                            })
                        } else {
                            completion(json,message,status)
                            print(message)
                            //                            if status == false {
                            //                                KRProgressHUD.dismiss({
                            //                                    PopupConfirmCommon.showRequestPopup(strMgs: message, strTitle: "Alert".localized)
                            //                                })
                            //                            }
                        }
                    }catch {
                        print("____api error", error)
                    }
                }
                
                break
            case .failure(let error):
                print("____api error", error)
                if error.code == -1009 {
                    KRProgressHUD.dismiss({
                        PopupConfirmCommon.showRequestPopup(strMgs: error.localizedDescription, strTitle: "Alert", strActionTitle: nil, isShowCloseButton: true, isRemoveAllSubview: true, acceptBlock: {
                        }, rejectBlock: nil)
                    })
                }
                else {
                    completion(JSON.null, error.localizedDescription,false)
                }
            }
            if showProgress {
                KRProgressHUD.dismiss()
            }
        }
        
        func showAlert(title: String = "", message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let startVC = mainStoryboard.instantiateViewController(withIdentifier: "StartVC")
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.window?.rootViewController = startVC
            }))
            let keyWindow: UIWindow? = UIApplication.shared.keyWindow
            let mainController: UIViewController? = keyWindow?.rootViewController
            mainController?.present(alert, animated: true)
        }
    }
    
    class func cancelAllRequests(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}

class JSONHelper {
    class func jsonStringWithObject(obj: AnyObject) -> String? {
        var error: NSError?
        do {
            let jsonData  = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
            return NSString(data: jsonData, encoding: 1) as String?
            
            
        } catch  {
            
        }
        if error != nil {
            print("Error creating JSON data: \(error!.description)");
            return nil
        }
        return ""
    }
}
