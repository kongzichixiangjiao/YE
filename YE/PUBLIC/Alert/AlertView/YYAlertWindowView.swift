//
//  YYWindow.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYWindow: UIWindow {
    
}

// MARK: window
protocol WindowProtocol {
    var alertWindow: YYWindow { set get }
    
    var alertWhiteWindow: YYWindow { set get }
}

extension UIView: WindowProtocol {
    var alertWhiteWindow: YYWindow {
        get {
            guard let window: YYWindow = objc_getAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow) as? YYWindow else {
                let alertWindow = YYWindow(frame: UIScreen.main.bounds)
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.backgroundColor = UIColor.clear
                alertWindow.becomeKey()
                alertWindow.makeKeyAndVisible()
                alertWindow.isHidden = false
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapWhiteWindow(_:)))
                alertWindow.addGestureRecognizer(tap)
                
                objc_setAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return alertWindow
            }
            return window
        }
        set {
            
        }
    }

    var alertWindow: YYWindow {
        get {
            guard let window: YYWindow = objc_getAssociatedObject(self, &YYAlertKey.kAlertWindow) as? YYWindow else {
                let alertWindow = YYWindow(frame: UIScreen.main.bounds)
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
                
                objc_setAssociatedObject(self, &YYAlertKey.kAlertWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return alertWindow
            }
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
        switch self.alertType {
        case .normal:
            hideLoadingView()
            break
        case .loading:
            hideLoadingView()
            break
        case .text:
            hideTextView()
            break
        case .selected:
            hideSelectedLoading()
            break
        case .birthday:
            hideBirthdayView()
            break
        case .textLoading:
            hideTextLoadingView()
            break 
        }
        ga_hideWindow(isWhite)
    }
    
    func ga_hideWindow(_ isWhite: Bool) {
        objc_setAssociatedObject(self, &YYAlertKey.kAlertType, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        if isWhite {
            self.alertWhiteWindow.resignKey()
            self.alertWhiteWindow.isHidden = true
            objc_setAssociatedObject(self, &YYAlertKey.kAlertWhiteWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        } else {
            self.alertWindow.resignKey()
            self.alertWindow.isHidden = true
            objc_setAssociatedObject(self, &YYAlertKey.kAlertWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
