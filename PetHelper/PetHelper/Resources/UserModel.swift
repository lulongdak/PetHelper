//
//  UserModel.swift
//  PetHelper
//
//  Created by Allen on 6/28/17.
//  Copyright © 2017 SUAY555. All rights reserved.
//

import Foundation

class UserModel: NSObject
{
    var userName: String?
    var phoneNumber: String?
    var address: String?
    var email: String?
    var profilePic: String?
    var userRole: String?
    var isFirstTime: String?
    //var id:String?
}

struct table_account {
    var id:String?
    var email:String?
}
