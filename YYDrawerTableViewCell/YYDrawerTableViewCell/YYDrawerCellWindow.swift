//
//  YYWindow.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYDrawerWindow: UIWindow {
    
}

// MARK: window
protocol WindowProtocol {
    var alertWindow: YYDrawerWindow { set get }
    
    var alertWhiteWindow: YYDrawerWindow { set get }
}

extension UIView: WindowProtocol {
    var alertWhiteWindow: YYDrawerWindow {
        get {
            guard let window: YYDrawerWindow = objc_getAssociatedObject(self, &YYDrawerAlertKey.kAlertWhiteWindow) as? YYDrawerWindow else {
                let alertWindow = YYDrawerWindow(frame: UIScreen.main.bounds)
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.backgroundColor = UIColor.clear
                alertWindow.becomeKey()
                alertWindow.makeKeyAndVisible()
                alertWindow.isHidden = false
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapWhiteWindow(_:)))
                alertWindow.addGestureRecognizer(tap)
                
                objc_setAssociatedObject(self, &YYDrawerAlertKey.kAlertWhiteWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return alertWindow
            }
            return window
        }
        set {
            
        }
    }
    
    var alertWindow: YYDrawerWindow {
        get {
            guard let window: YYDrawerWindow = objc_getAssociatedObject(self, &YYDrawerAlertKey.kAlertWindow) as? YYDrawerWindow else {
                let alertWindow = YYDrawerWindow(frame: UIScreen.main.bounds)
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.backgroundColor = UIColor.clear
                alertWindow.becomeKey()
                alertWindow.makeKeyAndVisible()
                alertWindow.isHidden = false
                
                let v = UIView()
                v.bounds = UIScreen.main.bounds
                v.center = alertWindow.center
                v.alpha = 0.25
                v.backgroundColor = UIColor.black
                alertWindow.addSubview(v)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapBackView(_:)))
                alertWindow.addGestureRecognizer(tap)
                
                objc_setAssociatedObject(self, &YYDrawerAlertKey.kAlertWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return alertWindow
            }
            print(window)
            return window
        }
        set {
            
        }
    }
    
    @objc func tapWhiteWindow(_ sender: UITapGestureRecognizer) {
        ga_dissmissWhiteWindow()
    }
    
    @objc func tapBackView(_ sender: UITapGestureRecognizer) {
        ga_dissmissBlackWindow()
    }
    
    func ga_dissmissBlackWindow() {
        ga_hideOtherView(false)
    }
    
    func ga_dissmissWhiteWindow() {
        ga_hideOtherView(true)
    }
    
    public func ga_hideOtherView(_ isWhite: Bool) {
        ga_hideWindow(isWhite)
    }
    
    func ga_hideWindow(_ isWhite: Bool) {
        for window in UIApplication.shared.windows {
            if window.isKind(of: YYDrawerWindow.self) {
                window.resignKey()
                window.isHidden = true
            }
        }
        if isWhite {
            objc_setAssociatedObject(self, &YYDrawerAlertKey.kAlertWhiteWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            objc_setAssociatedObject(self, &YYDrawerAlertKey.kAlertWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
