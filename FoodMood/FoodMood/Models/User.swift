//
//  User.swift
//  FoodMood
//
//  Created by Dhriti Chawla on 3/26/18.
//  Copyright © 2018 iOSGroupProject. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var profpic: String = ""
    var fname: String = ""
    var lname: String = ""
    var username: String = ""
    var bio: String = ""
    
    init(userInfo: [String: Any]) {
        profpic = userInfo["ProfilePicture"] as! String
        fname = userInfo["Fname"] as! String
        lname = userInfo["Lname"] as! String
        username = userInfo["Username"] as! String
        bio = userInfo["Bio"] as! String
    }
    
}
