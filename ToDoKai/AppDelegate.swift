//
//  AppDelegate.swift
//  ToDoKai
//
//  Created by Tan Christian on 17/11/18.
//  Copyright © 2018 Tan Christian. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print (Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            let realm = try Realm()
        } catch  {
            print ("Realm Error \(error)")
        }
        
        
        return true
    }

  


}

