//
//  UIViewController+Transition.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension UIViewController {
    public var yy_routerAnimation : YYTransition {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kRouterAnimationKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            guard let r = objc_getAssociatedObject(self, &YYTransitionKey.kRouterAnimationKey) as? YYTransition  else {
                return YYTransition()
            }
            return r
        }
    }
    
}

