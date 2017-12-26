//
//  UITableView+PlaceHolder.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  感谢 微博@iOS程序犭袁


/*
    self.tableView.emptyDelegate = self
 
    // 刷新使用yy_reloadData()
    self.tableView.yy_reloadData()
 */

import UIKit

protocol UITableViewPlaceHolderDelegate {
    func tableViewPlaceHolderView() -> UIView
    func tableViewEnableScrollWhenPlaceHolderViewShowing() -> Bool
}

extension UITableView {
    
    static var kEmptyDelegateKey: UInt = 149001
    static var kScrollWasEnabledKey: UInt = 149002
    static var kPlaceHolderViewKey: UInt = 149002
    
    var scrollWasEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &UITableView.kScrollWasEnabledKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.kScrollWasEnabledKey) as! Bool
        }
    }
    
    var placeHolderView: UIView? {
        set {
            objc_setAssociatedObject(self, &UITableView.kPlaceHolderViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.kPlaceHolderViewKey) as? UIView
        }
    }
    
    var emptyDelegate: UITableViewPlaceHolderDelegate? {
        set {
            objc_setAssociatedObject(self, &UITableView.kEmptyDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UITableView.kEmptyDelegateKey) as? UITableViewPlaceHolderDelegate
        }
    }
    
    public func yy_reloadData() {
        self.reloadData()
        self.yy_judgeEmpty()
    }
    
    private func yy_judgeEmpty() {
        var isEmpty: Bool = true
        let src = self.dataSource
        let sections = src?.numberOfSections!(in: self) ?? 1
        for i in 0..<sections {
            if let row = src?.tableView(self, numberOfRowsInSection: i) {
                if row > 0 {
                    isEmpty = false
                }
            }
        }
        if isEmpty && self.placeHolderView == nil {
            if isEmpty {
                self.scrollWasEnabled = self.isScrollEnabled
                
                if let emptyDelegate = self.emptyDelegate {
                    self.isScrollEnabled = self.emptyDelegate?.tableViewEnableScrollWhenPlaceHolderViewShowing() ?? self.isScrollEnabled
                    self.placeHolderView = emptyDelegate.tableViewPlaceHolderView()
                } else {
                    print("UITableView+PlacerHolder yy_judgeEmpty() 没遵守代理")
                }
                self.placeHolderView?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                if let placeHolderView = self.placeHolderView {
                    self.addSubview(placeHolderView)
                } else {
                    print("UITableView+PlacerHolder yy_judgeEmpty() 没有view")
                }
            } else {
                self.isScrollEnabled = self.scrollWasEnabled
                self.placeHolderView?.removeFromSuperview()
                self.placeHolderView = nil
            }
        } else {
            self.isScrollEnabled = true
            self.placeHolderView?.removeFromSuperview()
            self.placeHolderView = nil
        }
    }
}
