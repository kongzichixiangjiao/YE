//
//  YYTransition+Move.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYTransition {
    
    func moveAnimationTransition(isBack: Bool, using transitionContext: UIViewControllerContextTransitioning) {
        self.yy_transitionContext = transitionContext
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
        guard let fromVC = context.viewController(forKey: .from) else {
            return
        }
        guard let fPath = self.yy_fromViewPath else {
            return
        }
        guard let tPath = self.yy_toViewPath else {
            return
        }
        let fromView = fromVC.value(forKeyPath: fPath) as! UIView
        // 获取目标view
        let toView = toVC.value(forKeyPath: tPath) as! UIView
        
        
        // 获取源动画
        guard let snapView = fromView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        snapView.frame = containerView.convert(fromView.frame, from: fromView.superview)
        fromView.isHidden = true
        
        // 设置目标view的最终frame
        toVC.view.frame = context.finalFrame(for: toVC)
        toVC.view.alpha = 0
        
        toView.alpha = 0
        containerView.addSubview(snapView)
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0.0, options: .curveEaseInOut, animations: {
            containerView.layoutIfNeeded()
            toVC.view.alpha = 1
            snapView.frame = containerView.convert(toView.frame, to: toView.superview)
            toView.alpha = 1
        }) { (finished) in
            toView.isHidden = false
            fromView.isHidden = false
            snapView.removeFromSuperview()
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    func moveExecuteAnimationBack(using context: UIViewControllerContextTransitioning) {
        guard let toVC = context.viewController(forKey: .to) else { return }
        guard let fromVC = context.viewController(forKey: .from) else { return }
        guard let tPath = self.yy_toViewPath else {
            return
        }
        guard let fPath = self.yy_fromViewPath else {
            return
        }
        let fromView = fromVC.value(forKeyPath: tPath) as! UIView
        let toView = toVC.value(forKeyPath: fPath) as! UIView
        
        let containerView = context.containerView
        
        guard let snapView = fromView.snapshotView(afterScreenUpdates: false) else { return }
        snapView.frame = containerView.convert(fromView.frame, from: fromView.superview)
        fromView.isHidden = true
        toVC.view.frame = context.finalFrame(for: toVC)
        let originView = fromView
        originView.isHidden = true
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapView)
        
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            fromVC.view.alpha = 0.0
            snapView.frame = containerView.convert(originView.frame, from: originView.superview)
        }) { (finished) in
            snapView.removeFromSuperview()
            originView.isHidden = false
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
}

