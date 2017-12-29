//
//  YYTransition+Move.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYTransition where Base: UIViewController {
    
    func moveAnimationTransition(isBack: Bool, using transitionContext: UIViewControllerContextTransitioning) {
        base.yy_transitionContext = transitionContext
        if isBack {
            moveExecuteAnimationBack(using: transitionContext)
        } else {
            moveExecuteAnimation(using: transitionContext)
        }
    }
    
    func moveExecuteAnimation(using context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let toVC = context.viewController(forKey: .to) else {
            return
        }
        // 获取目标view
        let toView = toVC.value(forKeyPath: base.yy_toPathString!) as! UIView
        // 获取源动画
        guard let snapView = base.yy_fromView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        snapView.frame = containerView.convert(base.yy_fromView.frame, from: base.yy_fromView.superview)
        base.yy_fromView.isHidden = true
        
        // 设置目标view的最终frame
        toVC.view.frame = context.finalFrame(for: toVC)
        toVC.view.alpha = 0
        toVC.yy_fromView = base.yy_fromView
        toVC.yy_toPathString = base.yy_toPathString
        
        toView.alpha = 0
        containerView.addSubview(snapView)
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: base.transitionDuration(using: context), delay: 0.0, options: .curveEaseInOut, animations: {
            containerView.layoutIfNeeded()
            toVC.view.alpha = 1
            snapView.frame = containerView.convert(toView.frame, to: toView.superview)
            toView.alpha = 1
        }) { (finished) in
            toView.isHidden = false
            self.base.yy_fromView.isHidden = false
            snapView.removeFromSuperview()
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    func moveExecuteAnimationBack(using context: UIViewControllerContextTransitioning) {
        guard let toVC = context.viewController(forKey: .to) else { return }
        guard let fromVC = context.viewController(forKey: .from) else { return }
        let containerView = context.containerView
        let fromView = fromVC.value(forKeyPath: base.yy_toPathString!) as! UIView
        guard let snapView = fromView.snapshotView(afterScreenUpdates: false) else { return }
        snapView.frame = containerView.convert(fromView.frame, from: fromView.superview)
        fromView.isHidden = true
        toVC.view.frame = context.finalFrame(for: toVC)
        let originView = fromVC.yy_fromView
        originView.isHidden = true
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapView)
        
        UIView.animate(withDuration: base.transitionDuration(using: context), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            fromVC.view.alpha = 0.0
            snapView.frame = containerView.convert(originView.frame, from: originView.superview)
        }) { (finished) in
            snapView.removeFromSuperview()
            originView.isHidden = false
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
}

