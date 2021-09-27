//
//  AppConstant.swift
//  Entero Direct
//
//  Created by ADMIN on 17/04/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import Foundation

import UIKit

struct Metostim{
    
    enum GeneralError{
        case NoDataFound
    }

    //MARK: - For All Server Related Keys
    struct Server{
        
        //Headers
        static let HeaderKey = "X-Y-Z"
        
        static let HeaderValue = "X-Y-Z"
        //UAT :: http://13.127.131.56:8085/
        //Demo :: http://13.232.106.215:8082
        //http://13.232.106.215:8082
        //http://13.232.106.215:8083 = OG
        // http://13.127.131.56:8083 = EnteroDirect
        // Live : https://www.enterodirect.com/
        #if DEBUG
        static var BaseUrl = "http://114.79.184.110:7000/V1/"
        #else
        static var BaseUrl = "http://114.79.184.110:7000/V1/"
        #endif
        //SIGN-IN USER Profile Activity
        static let ProfileActivitySingIn = "Api/UserLogin"
        
        //GET TOKEN
        static let  GetToken = "auth/local"
        
        static let LoginApi =  "Api/UserLogin"

        //USER SIGN-UP
         static let Register =  "Api/IU_Registration"
        static let ValidateOTP =  "Api/ValidateOTP"
        static let ForgetPassword =  "Api/GenerateOTP"
        static let ChangePassword =  "Api/IU_ChangePassword"
        static let GetCountry =  "Api/GetCountry"
        static let GetBanners =  "Api/Getallimages"
        static let GetBirdType =  "Api/GetBirds"
        static let GetClimateType =  "Api/GetBirds"
        static let GetFormula =  "Api/GetFormulaData"

    }

    //Mark: Amount Symble
    struct AmountSymbol {
        static let MoneySymbol = "₹"
        static let IndianMoneySymbol = "Rs."

    }
    
    //MARK: - General Objects
    struct SharedObject
    {
        static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
        static let kUserDefaults = UserDefaults.standard
    }
    
    struct NavigationHeight
    {
        //Headers
        static let Navigation44PTSBarHeight     =   64
    }
    
    struct App
    {
        //Headers
        static let AppContentTypeHeaderKey = "Content-Type"
        static let AppContentTypeHeaderValue = "application/json"
        static let APPLng = "en"
        static let APPLngName = "English"
        
        static var AppNameTitle = "OrderGenie"
        static let GoogleApiKey = "327fb2f78a240d8ff2a8b31bf7369427"
        static let FirebaseKeyID = "1212121212"
        static let UserID = "UserId"
        static let userIDD = "userID"
        static let UserInfo = "UserInfo"
        static let IsUserLoggedIn = "isUserLoggedIn"
        static let DeviceId = "DeviceID"
        static let OrderGenieUserDataInfo = "UserDataInfo"
        static let OrderGenieUserRole = "UserRole"
        static let UserToken = "UserToken"
        static let uniCode: String = "\u{2588}"
        
        static let uniqueNo: String = "uniqueNo"
        static let chemistID: String = "chemistID"
        static let cityID: String = "cityID"
        static let stateID: String = "stateID"
        static let cartCount : String = "cartCount"
        static let notificationCount : String = "notificationCount"

        static let loyaltyCartCount : String = "loyaltyCartCount"
        static let draftCartCount : String = "draftCartCount"
        static let ERPID: String = "ERPID"
        static let ERPCODE: String = "ERPCODE"
        static let LOYALTYPOINT : String = "LOYALTYPOINT"
        
        
        static let NODataMessage = "Sorry, Nothing here! Tap to retry please select different filter."
        static let NODataMessageWithOutFilter = "Sorry, Nothing here! Tap to retry!"
        static let NOInternetMessage = "Sorry, seems like you are not connected to the internet!.\nPlease retry once you are connected."
        
        static let lastDataSyncedDate = "lastDataSyncedDate"
    }
    
    struct ColorScheme
    {
        static let AppViewBase = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)

        static let AppColor = UIColor.init(red: 0.0/255.0, green: 186.0/255.0, blue: 201.0/255.0, alpha: 0.8)
        static let Gray = UIColor.init(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        static let OrderStatusCompleted = UIColor.init(red: 53.0/255.0, green: 98.0/255.0, blue: 68.0/255.0, alpha: 1.0)
        static let OrderStatusSubmitted = UIColor.init(red: 255.0/255.0, green: 204.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

}
