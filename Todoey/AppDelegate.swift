//
//  AppDelegate.swift
//  Todoey
//
//  Created by Gavin Butler on 2018-03-31.
//  Copyright © 2018 Gavin Butler. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        print(Realm.Configuration.defaultConfiguration.fileURL!)
       
        do {
            _ = try Realm()
        } catch {
            print("Error initializing Realm database: \(error)")
        }
        
        return true
    }
}

