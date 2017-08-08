//
//  AppDelegate.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(NSHomeDirectory());
        hx_application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        hx_applicationDidEnterBackground(application)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        hx_applicationWillEnterForeground(application)
    }
}

