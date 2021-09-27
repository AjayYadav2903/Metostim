//
//  AccountInfo.swift
//  AirVting
//
//  Created by MACBOOK on 6/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON
//enum StatusAccount: Int {
//    case needVerifiedEmail = 1
//    case needConnectStrike = 2
//}
final class AccountInfo: NSObject, Codable {
    
    // Can't init is singleton
    private override init() { }
    
    // MARK: Shared Instance
    
    static let shared = AccountInfo()
    
    // MARK: Local Variable
    private var tokenId : String = ""
    var userID: Int?
    var Otp : Int?

    func saveAccountInfo(json: JSON){
        tokenId = json["Token"]["Token"].string ?? ""
        userID = json["Token"]["Userid"].int ?? 0
        Otp = json["Token"]["Otp"].int ?? 0

        UserDefaults.standard.set(tokenId, forKey: "tokenId")
        UserDefaults.standard.set(userID, forKey: "userID")
        UserDefaults.standard.set(Otp, forKey: "Otp")

    }
    
    func saveUserPhone(phone : String){
        UserDefaults.standard.set(phone, forKey: "phone_number")
    }
 
    
    func getPhone()->String{
        return UserDefaults.standard.string(forKey: "phone_number") ?? ""
    }
    
    func clearAccountInfo() {
        UserDefaults.standard.set("", forKey: "tokenId")
        UserDefaults.standard.set(nil, forKey: "userID")
        UserDefaults.standard.set(nil, forKey: "phone_number")

        self.clearUserModel()
    }

    func saveUserModel(user: UserModel){
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "UserModel")
        } else {
            print("save model error")
        }
    }
    func loadUserModel() -> UserModel{
        if let data = UserDefaults.standard.value(forKey: "UserModel") as? Data,
            let user = try? JSONDecoder().decode(UserModel.self, from: data) {
            return user
        }
        return UserModel()
    }
    func clearUserModel(){
        UserDefaults.standard.set(nil, forKey: "UserModel")
    }


    func getToken() -> String {
        return UserDefaults.standard.string(forKey: "tokenId") ?? ""
        
    }
  
}
