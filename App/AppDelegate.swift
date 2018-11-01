//
//  AppDelegate.swift
//  App
//
//  Created by Javed Multani on 24/07/18.
//  Copyright © 2018 iOS. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import NVActivityIndicatorView
import Realm
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var appRootController: UINavigationController?
    var navMenuController: UINavigationController?
    var navHomeController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(
            schemaVersion: 2,
            migrationBlock: { migration, oldSchemaVersion in
                
                if (oldSchemaVersion < 2) {
                    // Nothing to do!
                    
                }
        })
        Realm.Configuration.defaultConfiguration = config
        
//        let configCheck = Realm.Configuration();
//        let configCheck2 = Realm.Configuration.defaultConfiguration;
//        let schemaVersion = configCheck.schemaVersion
//        print("Schema version \(schemaVersion) and configCheck2 \(configCheck2.schemaVersion)")
        
        let configCheck = Realm.Configuration();
        do {
            let fileUrlIs = try schemaVersionAtURL(configCheck.fileURL!)
            print("schema version \(fileUrlIs)")
        } catch  {
            print(error)
        }
        
//        var config = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 87,
//
//            // Set the block which will be called automatically when opening a Realm with
//            // a schema version lower than the one set above
//            migrationBlock: { migration, oldSchemaVersion in
//                // We haven’t migrated anything yet, so oldSchemaVersion == 0
//                if (oldSchemaVersion < 86) {
//                    // Nothing to do!
//                    // Realm will automatically detect new properties and removed properties
//                    // And will update the schema on disk automatically
//                }
//        })
        
        // Tell Realm to use this new configuration object for the default Realm
  //      Realm.Configuration.defaultConfiguration = config
        
        
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        Thread.sleep(forTimeInterval: 2.0)
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.placeholderFont = THEME_FONT_LIGHT(size: 14)
        
        NVActivityIndicatorView.DEFAULT_TEXT_COLOR = UIColor.white
        NVActivityIndicatorView.DEFAULT_PADDING = CGFloat(0)
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        NVActivityIndicatorView.DEFAULT_BLOCKER_MINIMUM_DISPLAY_TIME = 0
        NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
        NVActivityIndicatorView.DEFAULT_BLOCKER_MESSAGE_FONT = THEME_FONT_MEDIUM(size: 20)

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "App")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

