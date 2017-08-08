//
//  YYEmptyTableView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

struct YYEmptyKey {
    static var kEmptyTypeKey: UInt = 2000001
    static var kAlertLabelKey: UInt = 2000002
    static var kAlertImageViewKey: UInt = 2000003
    static var kAlertButtonKey: UInt = 2000004
    static var kEmptyHandlerKey: UInt = 2000005
    
    static var kSpace: CGFloat = UIScreen.main.bounds.size.width / 4
}

public enum YYEmptyDataEnum: Int {
    case normal = 0, noData = 1, noDataReset = 2, noEmpty = 3
}

public protocol YYEmptyProtocol {
    var yy_emptyType: YYEmptyDataEnum { set get }
    var yy_alertButton: UIButton? { set get }
    var yy_alertLabel: UILabel? { set get }
    var yy_alertImageView: UIImageView? { set get }
    typealias YYEmptyHandler = () -> ()
    var emptyHandler: YYEmptyHandler? { set get }
    
    func yy_empty(_ type: YYEmptyDataEnum)
    func yy_empty(_ type: YYEmptyDataEnum, alertTitle: String)
    
    func yy_emptyWithReset(_ type: YYEmptyDataEnum, handler: YYEmptyHandler?)
}

extension UIScrollView: YYEmptyProtocol {
    public var emptyHandler: YYEmptyProtocol.YYEmptyHandler? {
        get {
            guard let handler = objc_getAssociatedObject(self, &YYEmptyKey.kEmptyHandlerKey) else {
                return nil
            }
            return handler as? YYEmptyProtocol.YYEmptyHandler
        }
        set {
            
        }
    }
    
    public var yy_emptyType: YYEmptyDataEnum {
        get {
            guard let type = objc_getAssociatedObject(self, &YYEmptyKey.kEmptyTypeKey) else {
                return YYEmptyDataEnum(rawValue: 0)!
            }
            return type as! YYEmptyDataEnum
        }
        set {

        }
    }
    
    public var yy_alertLabel: UILabel? {
        get {
            guard let alertLabel = objc_getAssociatedObject(self, &YYEmptyKey.kAlertLabelKey) else {
                let l = UILabel()
                l.frame = CGRect(x: 0, y: self.yy_alertImageView!.frame.origin.y + self.yy_alertImageView!.frame.size.height + 10, width: self.frame.size.width, height: 20)
                l.text = ""
                l.font = UIFont.systemFont(ofSize: 14)
                l.textAlignment = .center
                
                self.addSubview(l)
                objc_setAssociatedObject(self, &YYEmptyKey.kAlertLabelKey, l, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return l
            }
            return alertLabel as? UILabel
        }
        set {
            
        }
    }
    
    public var yy_alertButton: UIButton? {
        get {
            guard let alertLabel = objc_getAssociatedObject(self, &YYEmptyKey.kAlertButtonKey) else {
                let v = UIButton()
                v.frame = CGRect(x: self.frame.size.width / 2 - 100 / 2, y: self.yy_alertImageView!.frame.origin.y + self.yy_alertImageView!.frame.size.height + 10, width: 100, height: 40)
                v.setTitle("点击刷新", for: .normal)
                v.setTitleColor(UIColor.randomColor(), for: .normal)
                v.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                v.addTarget(self, action: #selector(alertButtonAction), for: .touchUpInside)
                self.addSubview(v)
                
                objc_setAssociatedObject(self, &YYEmptyKey.kAlertButtonKey, v, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return v
            }
            return alertLabel as? UIButton
        }
        set {
        }
    }
    
    // 如果初始化错误 emptyHandler = nil
    func alertButtonAction() {
        self.emptyHandler?()
    }
    
    public var yy_alertImageView: UIImageView? {
        get {
            guard let alertImageview = objc_getAssociatedObject(self, &YYEmptyKey.kAlertImageViewKey) else {
                
                let image = UIImage(named: self.yy_emptyType == .noData ? "public_empty_noData" : "public_empty_reset")
                
                let v = UIImageView()
                v.frame = CGRect(x: self.frame.width / 2 - image!.size.width / 2, y: self.frame.height / 2 - image!.size.width / 2 - YYEmptyKey.kSpace, width: image!.size.width, height: image!.size.height)
                v.image = image
                
                self.addSubview(v)
                
                if self.yy_emptyType == .noDataReset {
                    v.isUserInteractionEnabled = true
                    let tap = UITapGestureRecognizer(target: self, action: #selector(alertButtonAction))
                    v.addGestureRecognizer(tap)
                }
                
                objc_setAssociatedObject(self, &YYEmptyKey.kAlertImageViewKey, v, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return v
            }
            return alertImageview as? UIImageView
        }
        set {
            
        }
    }
    // MARK: 调用方法
    public func yy_empty(_ type: YYEmptyDataEnum) {
        if (type == .noDataReset) { return }
        updateEmptyView(type: type, alertTitle: "", handler: nil)
    }
    
    public func yy_empty(_ type: YYEmptyDataEnum, alertTitle: String) {
        if (type == .noDataReset) { return }
        updateEmptyView(type: type, alertTitle: alertTitle, handler: nil)
    }
    
    public func yy_emptyWithReset(_ type: YYEmptyDataEnum = .noDataReset, handler: YYEmptyProtocol.YYEmptyHandler?) {
        updateEmptyView(type: type, alertTitle: "", handler: handler)
    }
    
    private func updateEmptyView(type: YYEmptyDataEnum, alertTitle: String, handler: YYEmptyProtocol.YYEmptyHandler?) {
        
        guard let _: YYEmptyDataEnum = objc_getAssociatedObject(self, &YYEmptyKey.kEmptyTypeKey) as? YYEmptyDataEnum else {
            
            self.initEmptyView(type: type, alertTitle: alertTitle, handler: handler)
            return
        }
        
        self.updateNoEmpty()
        
        self.initEmptyView(type: type, alertTitle: alertTitle, handler: handler)
        
    }
    
    private func updateNoEmpty() {
        guard let _: UIImageView = objc_getAssociatedObject(self, &YYEmptyKey.kAlertImageViewKey) as? UIImageView else {
            return
        }
        self.yy_alertImageView?.removeFromSuperview()
        objc_setAssociatedObject(self, &YYEmptyKey.kAlertImageViewKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        if (self.yy_emptyType == .noData) {
            guard let _: UILabel = objc_getAssociatedObject(self, &YYEmptyKey.kAlertLabelKey) as? UILabel else {
                return
            }
            self.yy_alertLabel?.removeFromSuperview()
            
            objc_setAssociatedObject(self, &YYEmptyKey.kAlertLabelKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return
        }
        
        if (self.yy_emptyType == .noDataReset) {
            guard let _: UIButton = objc_getAssociatedObject(self, &YYEmptyKey.kAlertButtonKey) as? UIButton else {
                return
            }
            self.yy_alertButton?.removeFromSuperview()
            
            objc_setAssociatedObject(self, &YYEmptyKey.kAlertButtonKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &YYEmptyKey.kEmptyHandlerKey, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return
        }
    }
    
    private func initEmptyView(type: YYEmptyDataEnum, alertTitle: String, handler: YYEmptyProtocol.YYEmptyHandler?) {
        objc_setAssociatedObject(self, &YYEmptyKey.kEmptyTypeKey, type, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        
        switch type {
        case .normal:
            break
        case .noData:
            self.yy_alertImageView?.show()
            self.yy_alertLabel?.text = alertTitle
            break
            
        case .noDataReset:
            self.yy_alertImageView?.show()
            self.yy_alertButton?.show()
            objc_setAssociatedObject(self, &YYEmptyKey.kEmptyHandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            break
            
        case .noEmpty:
            self.updateNoEmpty()
            break
        }
    }
}
