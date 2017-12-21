//
//  YYAlertView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  alert提醒

import UIKit

struct YYAlertKey {
    
    static var kAlertType: UInt = 10006
    static var kToastView: UInt = 10007
    static var kLoadingView: UInt = 10008
    static var kActivity: UInt = 10009
    static var kAlertWindow: UInt = 10010
    static var kTableView: UInt = 10011
    static var kDidSelectedHandler: UInt = 10012
    static var kSelectedData: UInt = 10013
    static var kSelectedHeaderView: UInt = 10014
    static var kBirthdayView: UInt = 10015
    static var kAlertWhiteWindow: UInt = 10016
    static var kAlertTextLabel: UInt = 10017
    static var kTextToastView: UInt = 10018
    static var kLoadingTextLabel: UInt = 10019
    static var kLoadingIconImageView: UInt = 10020
    
}

enum YYAlertViewTextType: String {
    case success = "alert_success", error = "alert_error", loading = "加载中"
}

enum YYAlertType: Int {
    case normal = 0, text = 1, birthday = 2, selected = 3, loading = 4, textLoading = 5
}

protocol AlertTypeProtocol {
    var alertType: YYAlertType { set get }
}

extension UIView: AlertTypeProtocol {
    var alertType: YYAlertType {
        get {
            guard let type = objc_getAssociatedObject(self, &YYAlertKey.kAlertType) else {
                return YYAlertType(rawValue: 0)!
            }
            return type as! YYAlertType
        }
        set {
            
        }
    }
    
    func ga_showView(_ text: String, deplay: Double = 0) {
        setup(.text)
        showView(text)
        if deplay != 0 {
            let queue = DispatchQueue.global(qos: .default)
            queue.asyncAfter(deadline: DispatchTime.now() + Double(Int64(deplay * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
                [weak self] in
                if let weakSelf = self {
                    DispatchQueue.main.async {
                        weakSelf.ga_hideTextView()
                    }
                }
            })
        }
    }
    
    func ga_hideTextView() {
        ga_dissmissWhiteWindow()
    }
    
    func ga_showBirthdayView(_ handler: @escaping DidSelectedHandler) {
        setup(.birthday)
        showBirthdayView(handler)
    }
    
    func ga_hideBirthdayView() {
        ga_dissmissBlackWindow()
    }
    
    // MARK: selected
    // MARK: loading
    func ga_showSelectedLoading(_ title: String = "请选择", data: [Any], handler: @escaping DidSelectedHandler) {
        setup(.selected)
        showSelectedLoading(title, data: data, handler)
    }
    
    public func ga_hideSelectedLoading() {
        ga_dissmissBlackWindow()
    }
    
    // MARK: loading
    public func ga_showLoading() {
        setup(.loading)
        showLoadingView()
    }
    
    public func ga_hideLoading() {
        ga_dissmissBlackWindow()
    }
    
    // MARK: text loading
    func ga_showTextLoading(_ type: YYAlertViewTextType, text: String) {
        setup(.textLoading)
        showTextLoadingView(type, text: text)
    }
    
    public func ga_hideTextLoading() {
        ga_dissmissBlackWindow()
    }
    
    fileprivate func setup(_ type: YYAlertType) {
        objc_setAssociatedObject(self, &YYAlertKey.kAlertType, type, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
