//
//  YYTransition.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

public enum YYTransitionAnimationType {
    case circle(isBack: Bool)
    case move(isBack: Bool)
    case middle(isBack: Bool)
    case tier(isBack: Bool)
}

public final class YYTransition<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol YYCompatible {
    associatedtype Y
    var yyPush: Y {
        get
    }
}

extension YYCompatible {
    public var yyPush: YYTransition<Self> {
        get {
            return YYTransition(self)
        }
    }
}
extension YYTransition where Base: UIViewController {
    
    public func setDelegate() {
        guard let nav = base.navigationController else {
            return
        }
        nav.delegate = base
    }
    
    public func transition(type: YYTransitionAnimationType, fromView: UIView? = nil, toViewPath: String? = nil) {
        base.yy_ransitionAnimationType = type
        guard let v = fromView else {
            return
        }
        base.yy_fromView = v
        guard let path = toViewPath else {
            return
        }
        base.yy_toPathString = path
    }
}






