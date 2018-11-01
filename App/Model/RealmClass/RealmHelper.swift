//
//  RealmHelper.swift
//  iOS
//
//  Created by Javed Multani on 24/05/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class DBManager {
    
    var database:Realm
    
    static let sharedInstance:DBManager = {
        let instance = DBManager ()
        return instance
    } ()
    
    private init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 0 {
                    /*migration.enumerateObjects(ofType: Route.className()) { (_, newRoute) in
                        newRoute?["Name"] = "Route".localized
                    }*/
                }
        })
        Realm.Configuration.defaultConfiguration = config
        
        _ = try! Realm.performMigration()

        database = try! Realm()
    }
    
    
    private func safeTransaction(withBlock block: @escaping ()
        -> Void) {
        if !DBManager.sharedInstance.database.isInWriteTransaction {
            DBManager.sharedInstance.database.beginWrite()
        }
        block()
        if DBManager.sharedInstance.database.isInWriteTransaction {
            do {
                try DBManager.sharedInstance.database.commitWrite()
            }
            catch {
                DLog(error.localizedDescription)
            }
        }
    }
    
    //NSPredicate(format: "featuretype > 0")
    //[SortDescriptor(keyPath: "Author", ascending: true),
    // SortDescriptor(keyPath: "Title", ascending: true)
    func fetchObjects<T: Object>(type: T.Type, predicate: NSPredicate?, order: [SortDescriptor]?) -> Results<T>? {
        var results = DBManager.sharedInstance.database.objects(type)
        if predicate != nil {
            results = results.filter(predicate!)
        }
        if order != nil {
            results = results.sorted(by: order!)
        }
        return results
    }
    
    func addObject(object: Object?, update: Bool? = false) {
        safeTransaction {
            if object != nil {
                DBManager.sharedInstance.database.add(object!, update: update!)
            }
        }
    }
    func editObjects(object: Object?) {
        
        safeTransaction {
            if object != nil {
                DBManager.sharedInstance.database.add(object!, update: true)
            }
        }
    }
    func editObject(object:Object,key:String,value:Any?){
        safeTransaction {
            object[key] = value
            DBManager.sharedInstance.database.add(object, update: true)
        }
    }
    
    func addAllObjects<T: Object>(list: [T]?, update: Bool? = false) {
        safeTransaction {
            DBManager.sharedInstance.database.add(list!, update: update!)
        }
    }
    
    func addAllObjectsFormDic<T: Object>(_ type: T.Type, value: Any = [:], update: Bool = false){
        safeTransaction {
            DBManager.sharedInstance.database.create(type, value: value, update: update)
        }
    }
    
    func updateObject(updateBlock: @escaping () -> ()) {
        safeTransaction {
            updateBlock()
        }
    }
    
    func deleteObject(_ object: Object?) {
        safeTransaction {
            if object != nil {
                DBManager.sharedInstance.database.delete(object!)
            }
        }
    }
    
    func deleteObjects<T: Object>(_ type: T.Type) {
        safeTransaction {
            let allObj = DBManager.sharedInstance.database.objects(type)
            DBManager.sharedInstance.database.delete(allObj)
        }
    }
    
    
    func deleteAllFromDatabase()  {
        safeTransaction {
            DBManager.sharedInstance.database.deleteAll()
        }
    }
    
   
    
}

/*
 **** Add Objects ****
 let realm = try! Realm()
 realm.addObject(object: self.classObject, update: true) //True
 - update object & False - new object
 //Multiple
 let realm = try! Realm()
 var contentArray = [CLASS]()
 //Your Custom Logic
 dictResponse?.enumerateObjects({ (dict,idx,stop) in
 contentArray.insert(CLASS.init(dictionary: dict as!
 NSDictionary), at:0)
 })
 realm.addAllObjects(list: contentArray, update: true)
 **** Fetch Objects ****
 Only Objects:
 arrObjects = try! Realm().fetchObjects(type: CLASS1.self,
 predicate: nil, order: nil)
 Objects with Predicate:
 arrObjects = realm.fetchObjects(type: CLASS3.self, predicate:
 NSPredicate(format: “property1 != 0 AND NOT (property2 IN
 %@)", arrNotIn), order: nil)
 Objects with Sorting:
 arrObjects = realm.fetchObjects(type: CLASS2.self, predicate:
 nil, order: [SortDescriptor(keyPath: “property1”, ascending:
 false), SortDescriptor(keyPath: “property2”, ascending:
 false), SortDescriptor(keyPath: “property3”, ascending:
 false)])
 **** Delete Objects ****
 let realm = try! Realm()
 realm.deleteObject(object: classObject)
 **** NOTE ****
 - All Transactions are written within Safe Transactions. So,
 it’ll not lock any thread.
 
 */
