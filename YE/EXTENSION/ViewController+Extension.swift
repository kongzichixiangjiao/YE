//
//  ViewController+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/8.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

// MARK: let _ = UIViewController.share
// 统计界面使用 方法交换
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


// MARK: - Push Pop 方法
extension UIViewController {
    /// PUSH
    func yy_push(vc: UIViewController, animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        nv.pushViewController(vc, animated: animated)
    }
    /// PUSH XIB
    func yy_pushXIB(nibName: String, animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        let vc = UIViewController(nibName: nibName, bundle: nil)
        nv.pushViewController(vc, animated: animated)
    }
    /// POP
    func yy_pop(animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        nv.popViewController(animated: animated)
    }
    /// POPTO
    func yy_popTo(vc: UIViewController, animted: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        for item in nv.viewControllers {
            if item == vc {
                nv.popToViewController(vc, animated: true)
                return
            }
        }
        print("没有目标UIViewController")
    }
    /// POPROOT
    func yy_popRoot(animated: Bool = true) {
        guard let nv = self.navigationController else {
            print("没有navigationController")
            return
        }
        nv.popToRootViewController(animated: true);
        
    }
    /// PRESENT
    func yy_present(animated: Bool = true) {
        present(self, animated: animated, completion: nil)
    }
    // storyboar PUSH
    func yy_push(storyboardName name: String, animated: Bool = true) {
        if name.isEmpty {
            print("name字符串为空")
            return
        }
        guard let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() else {
            print("没有viewcontroller")
            return
        }
        yy_push(vc: vc, animated: animated)
    }
    // storyboar PUSH
    func yy_push(storyboardName name: String, vcIdentifier identifier: String, animated: Bool = true) {
        if name.isEmpty || identifier.isEmpty {
            print("字符串有空")
            return
        }
        let vc = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
        yy_push(vc: vc, animated: animated)
    }
    
}

// 提醒

extension UIViewController {
    
    func yy_showTopSheet(message: String, isNav: Bool) {
        let height: CGFloat = 44
        let v = UIView(frame: CGRect(x: 0, y: -height + (isNav ? 64 : 0) , width: self.view.frame.width, height: height))
        v.tag = 20180313
        v.backgroundColor = UIColor.orange
        self.view.addSubview(v)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
            v.frame = CGRect(x: 0, y: isNav ? 64 : 0, width: self.view.frame.width, height: height)
        }) { (finish) in
            if (finish) {
                
            }
        }
    }
    
    func yy_hideTopSheet(isNav: Bool) {
        let height: CGFloat = 44
        var v = self.view.viewWithTag(20180313)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
            v?.frame = CGRect(x: 0, y: -height + (isNav ? 64 : 0) , width: self.view.frame.width, height: height)
        }) { (finish) in
            if (finish) {
                v?.removeFromSuperview()
                v = nil
            }
        }
    }
    
}
