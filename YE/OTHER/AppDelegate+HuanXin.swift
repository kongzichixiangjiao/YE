//
//  AppDelegate+HuanXin.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/11.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import EaseUILite

extension AppDelegate {
    
    func hx_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        //AppKey:注册的AppKey，详细见下面注释。
        //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
        let options = EMOptions.init(appkey: HuanXin.key)
        EMClient.shared().initializeSDK(with: options)
        
        hx_regist()
        hx_login()
    }
    
    func hx_applicationDidEnterBackground(_ application: UIApplication) {
        EMClient.shared().applicationDidEnterBackground(application)
    }
    
    func hx_applicationWillEnterForeground(_ application: UIApplication) {
        EMClient.shared().applicationWillEnterForeground(application)
    }
    
    private func hx_regist() {
        HXManager.hx_register {
            [weak self] success in
            if let weakSelf = self {
                if success {
                    weakSelf.window?.ga_showView(text: "注册成功", deplay: 1.22)
                }
            }
        }
    }
    
    private func hx_login() {
        HXManager.hx_login {
            [weak self] success in
            if let weakSelf = self {
                if success {
                    weakSelf.window?.ga_showView(text: "登陆成功", deplay: 1.22)
                }
            }
        }
    }
}
