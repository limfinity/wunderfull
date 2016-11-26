//
//  AppDelegate.swift
//  Wunderfull
//
//  Created by Peter Pult on 25/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {        
        // For this usecase delete the old database when migration is needed
        Realm.Configuration.defaultConfiguration.deleteRealmIfMigrationNeeded = true
        
        return true
    }
    
}

