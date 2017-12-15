//
//  AppDelegate+Root.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

extension AppDelegate {

    func rooter(isAD: Bool = true) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: YYTabBarController.identifier)
        let vc = YYADViewController(nibName: "YYADViewController", bundle: nil)
        self.window?.rootViewController = isAD ? vc : rootVC
        self.window?.makeKeyAndVisible()
    }
    
}
