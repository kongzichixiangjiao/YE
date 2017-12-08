//
//  ViewController+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/8.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

// MARK: let _ = UIViewController.share
extension UIViewController {
    static let share: UIViewController = UIViewController(swizzle: true)
    
    convenience init(swizzle: Bool) {
        self.init()
        
        // viewWillAppear
        let originalSelector = #selector(UIViewController.viewWillAppear(_:))
        let swizzledSelector = #selector(UIViewController.yy_viewWillAppear(animated:))
        
        let originalMethod = class_getInstanceMethod(UIViewController.classForCoder(), originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIViewController.classForCoder(), swizzledSelector)
        
        let didAddMethod = class_addMethod(UIViewController.classForCoder(), originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        
        if didAddMethod {
            class_replaceMethod(UIViewController.classForCoder(), swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!);
        }
        
        // viewDidDisappear
        let originalSelector1 = #selector(UIViewController.viewDidDisappear(_:))
        let swizzledSelector1 = #selector(UIViewController.yy_viewDidDisappear(animated:))
        
        let originalMethod1 = class_getInstanceMethod(UIViewController.classForCoder(), originalSelector1)
        let swizzledMethod1 = class_getInstanceMethod(UIViewController.classForCoder(), swizzledSelector1)
        
        let didAddMethod1 = class_addMethod(UIViewController.classForCoder(), originalSelector1, method_getImplementation(swizzledMethod1!), method_getTypeEncoding(swizzledMethod1!))
        if didAddMethod1 {
            class_replaceMethod(UIViewController.classForCoder(), swizzledSelector1, method_getImplementation(originalMethod1!), method_getTypeEncoding(originalMethod1!))
        } else {
            method_exchangeImplementations(originalMethod1!, swizzledMethod1!)
        }
    }
    
    // MARK: - Method Swizzling
    @objc func yy_viewWillAppear(animated: Bool) {
        self.yy_viewWillAppear(animated: animated)
        print("yy_viewWillAppear" + self.description)
    }
    
    @objc func yy_viewDidDisappear(animated: Bool) {
        self.yy_viewDidDisappear(animated: animated)
        print("yy_viewDidDisappear" + self.description)
    }
}
