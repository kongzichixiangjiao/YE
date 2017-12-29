//
//  UIViewController+Transition.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

struct YYTransitionKey {
    static var kTransitonAnimationTypeKey: UInt = 12271740
    static var kFromViewKey: UInt = 12271741
    static var kToPathStringKey: UInt = 12271742
    static var kTransitionContextKey: UInt = 12271743
}

// MARK: 动画执行时间
private let kTransitionDuration: Double = 0.35
//private let kTransitionDuration: Double = 3

// MARK: UIViewController遵守YYCompatible协议
extension UIViewController: YYCompatible {}

// MARK: CAAnimationDelegate
extension UIViewController: CAAnimationDelegate {
    // 使用base动画结束时
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard flag else { return }
        // This must be called whenever a transition completes (or is cancelled.)
        // Typically this is called by the object conforming to the
        // UIViewControllerAnimatedTransitioning protocol that was vended by the transitioning
        // delegate.  For purely interactive transitions it should be called by the
        // interaction controller. This method effectively updates internal view
        // controller state at the end of the transition.
        yy_transitionContext.completeTransition(!yy_transitionContext.transitionWasCancelled)
        yy_transitionContext.viewController(forKey: .from)?.view.layer.mask = nil
        yy_transitionContext.viewController(forKey: .to)?.view.layer.mask = nil
    }
}


extension UIViewController {
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
    var yy_fromView: UIView {
        set {
            objc_setAssociatedObject(self, &YYTransitionKey.kFromViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &YYTransitionKey.kFromViewKey) as! UIView
        }
    }
    // 目标view名字
    var yy_toPathString: String? {
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

extension UIViewController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

extension UIViewController: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return kTransitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.yy_ransitionAnimationType {
        case .circle(let isBack):
            yyPush.circleAnimateTransition(isBack: isBack, using: transitionContext)
            break
        case .move(let isBack):
            yyPush.moveAnimationTransition(isBack: isBack, using: transitionContext)
            break
        case .middle(let isBack):
            yyPush.middleAnimationTransition(isBack: isBack, using: transitionContext)
        case .tier(let isBack):
            yyPush.tierAnimationTransition(isBack: isBack, using: transitionContext)
        }
    }
    
}
