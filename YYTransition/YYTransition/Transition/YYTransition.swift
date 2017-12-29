//
//  YYTransition.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

struct YYTransitionKey {
    static var kTransitonAnimationTypeKey: UInt = 12271740
    static var kFromViewKey: UInt = 12271741
    static var kToPathStringKey: UInt = 12271742
    static var kTransitionContextKey: UInt = 12271743
    static var kRouterAnimationKey: UInt = 12271744
    static var kIsBackKey: UInt = 12271745
}

// MARK: 动画执行时间
private let kTransitionDuration: Double = 0.35

public enum YYTransitionAnimationType {
    case circle
    case move
    case middle
    case tier
}

public class YYTransition: NSObject {

    convenience public init(type: YYTransitionAnimationType, isBack: Bool = false, fromeViewPath: String? = nil, toViewPath: String? = nil) {
        self.init()
        self.yy_ransitionAnimationType = type
        self.yy_isBack = isBack
        self.yy_fromViewPath = fromeViewPath
        self.yy_toViewPath = toViewPath
    }
}

extension YYTransition: UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.yy_ransitionAnimationType {
        case .circle:
            circleAnimateTransition(isBack: yy_isBack, using: transitionContext)
            break
        case .move:
            moveAnimationTransition(isBack: yy_isBack, using: transitionContext)
            break
        case .middle:
            middleAnimationTransition(isBack: yy_isBack, using: transitionContext)
            break
        case .tier:
            tierAnimationTransition(isBack: yy_isBack, using: transitionContext)
            break
        }
    }
}
extension YYTransition {
    public var yy_isBack: Bool {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kIsBackKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            return objc_getAssociatedObject(self, &YYTransitionKey.kIsBackKey) as! Bool
        }
    }
    // 动画类型
    var yy_ransitionAnimationType: YYTransitionAnimationType {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kTransitonAnimationTypeKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &YYTransitionKey.kTransitonAnimationTypeKey) as! YYTransitionAnimationType
        }
    }
    // 源view
    var yy_fromViewPath: String? {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kFromViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &YYTransitionKey.kFromViewKey) as? String
        }
    }
    // 目标view名字
    var yy_toViewPath: String? {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kToPathStringKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &YYTransitionKey.kToPathStringKey) as? String
        }
    }
    // UIViewControllerContextTransitioning
    var yy_transitionContext: UIViewControllerContextTransitioning {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kTransitionContextKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &YYTransitionKey.kTransitionContextKey) as! UIViewControllerContextTransitioning
        }
    }
}

extension YYTransition: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        yy_transitionContext.completeTransition(!yy_transitionContext.transitionWasCancelled)
        yy_transitionContext.viewController(forKey: .from)?.view.layer.mask = nil
        yy_transitionContext.viewController(forKey: .to)?.view.layer.mask = nil
    }
}





