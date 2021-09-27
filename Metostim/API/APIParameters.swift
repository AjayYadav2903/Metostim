//
//  APIParameters.swift
//  Entero Direct
//
//  Created by ADMIN on 17/04/19.
//  Copyright © 2019 ADMIN. All rights reserved.
//

import Foundation

struct AuthonticationParams {
    static let kMobile = "Mobileno"
    static let kPassword = "UserPwd"
}

struct AuthonticationParamsSignUp {
    static let kName = "name"
    static let kEmail = "email"
    static let kMobile = "mobile"
    static let kPassword = "userpassword"
    static let kCountry = "country"
    static let kCountryCode = "country_code"
}

struct AuthonticationValidateOTP {
    static let kUserID = "userid"
    static let kOTP = "OTP"
  
}

struct AuthonticationChangePassword {
    static let kUserID = "userid"
    static let kUserPassword = "userpassword"
  
}

struct AuthonticationForgetPassword {
    static let kMobileNo = "Mobile"
}


