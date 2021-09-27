//
//  UserModel.swift
//  Rooms24india
//
//  Created by admin on 20/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import SwiftyJSON

struct UserModel: Codable, Equatable {

    var Userid : Int = 0
    var Token : String = ""
    
    init (){
        
    }
    init(json: JSON) {
        //FIELD FORCE
        Userid = json["Userid"].int ?? 0
        Token = json["Token"].string ?? ""
    }
}
