//
//  RObjUser.swift
//  App
//
//  Created by Javed Multani on 24/07/18.
//  Copyright © 2018 iOS. All rights reserved.
//
import Realm
import RealmSwift
import UIKit

class RObjUser: Object {
    
    @objc dynamic var firstName: String?
    @objc dynamic var lastName: String?
    @objc dynamic var gender: String?
    @objc dynamic var mobileNum = 0
    @objc dynamic var email = ""
    @objc dynamic var password: String?
   
    
//    override static func primaryKey() -> String? {
//        return "email"
//    }
//    override static func indexedProperties() -> [String] {
//        return ["firstName"]
//    }
}
