//
//  DefaulValues.swift
//
//
//  Created by C217 on 22/04/16.
//  Copyright © 2017 Javed Multani C81. All rights reserved.
//

import Foundation


public func setStringValueToUserDefaults(_ strValue: String, _ ForKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.setValue("\(strValue)", forKey: ForKey)
    defaults.synchronize()
}

public func getStringValueFromUserDefaults_ForKey(_ strKey: String) -> String {
    
    let defaults = UserDefaults.standard
    var s: String? = nil
    s = defaults.string(forKey: strKey)
    return s!
}

public func setIntegerValueToUserDefaults(_ intValue: Int, _ ForKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.set(intValue, forKey: ForKey)
    defaults.synchronize()
}

public func getIntegerValueFromUserDefaults_ForKey(_ intKey: String) -> Int {
    
    var i: Int = 0
    let defaults = UserDefaults.standard
    i = Int(defaults.integer(forKey: intKey))
    
    return i
}

public func setBooleanValueToUserDefaults(_ booleanValue: Bool, _ ForKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.set(booleanValue, forKey: ForKey)
    defaults.synchronize()
    
}

public func getBooleanValueFromUserDefaults_ForKey(_ booleanKey: String) -> Bool {
    
    let defaults = UserDefaults.standard
    
    var b: Bool = false
    b = defaults.bool(forKey: booleanKey)
    
    return b
}


public func setObjectValueToUserDefaults(_ idValue: AnyObject, _ ForKey: String) {
    
    let defaults = UserDefaults.standard
    
    defaults.set(idValue, forKey: ForKey)
    defaults.synchronize()
    
}

public func getObjectValueFromUserDefaults_ForKey(_ strKey: String) -> AnyObject {
    
    let defaults = UserDefaults.standard
    var obj: AnyObject? = nil
    obj = defaults.object(forKey: strKey) as AnyObject
    
    return obj!
}

public func setCustomObjToUserDefaults(_ CustomeObj: AnyObject, _ ForKey: String) {
    
    let defaults = UserDefaults.standard
    
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: CustomeObj)
    defaults.set(encodedData, forKey: ForKey)
    defaults.synchronize()
    
}

public func getCustomObjFromUserDefaults_ForKey(_ CustomeObjKey: String) -> AnyObject {
    
    let defaults = UserDefaults.standard
    
    let decoded  = defaults.object(forKey: CustomeObjKey) as! NSData
    let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)! as AnyObject
    return decodedTeams
}

public func removeObjectForKey(_ objectKey: String) {
    
    let defaults = UserDefaults.standard
    defaults.removeObject(forKey: objectKey)
    defaults.synchronize()
}


//public func isKeyAvailbaleInDefault(key: String) -> Bool {
//
//    var defaults: NSUserDefaults = UserDefaults.standard
//    return defaults.dictionaryRepresentation().allKeys().containsObject(key)
//}

public func iskeyAlreadyExist(_ key: String) -> Bool {
    return UserDefaults.standard.object(forKey: key) != nil
}

