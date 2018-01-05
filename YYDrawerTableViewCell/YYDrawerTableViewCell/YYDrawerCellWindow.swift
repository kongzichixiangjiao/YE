////
////  YYWindow.swift
////  YueYe
////
////  Created by 侯佳男 on 2017/6/14.
////  Copyright © 2017年 侯佳男. All rights reserved.
////
//
//import UIKit
//
//class YYDrawerWindow: UIWindow {
//    
//}
//
//extension UIView {
//    
//    var alertWhiteWindow: YYDrawerWindow {
//        get {
//            guard let window: YYDrawerWindow = objc_getAssociatedObject(self, &YYDrawerAlertKey.kAlertWhiteWindow) as? YYDrawerWindow else {
//                let alertWindow = YYDrawerWindow(frame: UIScreen.main.bounds)
//                alertWindow.windowLevel = UIWindowLevelAlert
//                alertWindow.backgroundColor = UIColor.blue
//                alertWindow.alpha = 0.3
//                alertWindow.becomeKey()
//                alertWindow.makeKeyAndVisible()
//                alertWindow.isHidden = false
//                
//                let tap = UITapGestureRecognizer(target: self, action: #selector(tapWhiteWindow(_:)))
//                alertWindow.addGestureRecognizer(tap)
//                
//                objc_setAssociatedObject(self, &YYDrawerAlertKey.kAlertWhiteWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//                
//                return alertWindow
//            }
//            return window
//        }
//        set {
//            
//        }
//    }
//    
//    
//    @objc func tapWhiteWindow(_ sender: UITapGestureRecognizer) {
//        ga_dissmissWhiteWindow()
//    }
//    
//    func ga_dissmissWhiteWindow() {
//        self.alertWhiteWindow.resignKey()
//        self.alertWhiteWindow.isHidden = true
//        objc_setAssociatedObject(self, &YYDrawerAlertKey.kAlertWhiteWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//}

