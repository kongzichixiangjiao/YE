//
//  UIResponder+Extensino.swift
//  YYPlayer
//
//  Created by 侯佳男 on 2018/5/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
// MARK: extension UIResponder
var extension_key: UInt = 12057676
public extension UIResponder {
    
    public var allowRotation: Bool? {
        get {
            return objc_getAssociatedObject(self, &extension_key) as? Bool
        }
        set(newValue) {
            objc_setAssociatedObject(self, &extension_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // UIDevice.current.setValue(value, forKey: kOrientation) 之后调用此方法
    @objc(application:supportedInterfaceOrientationsForWindow:) func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if allowRotation == true {
            return .landscapeRight
        } else {
            return .portrait
        }
    }
}
