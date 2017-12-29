//
//  YYTransition+Move.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  层

import UIKit

extension YYTransition {
    
    func tierAnimationTransition(isBack: Bool, using transitionContext: UIViewControllerContextTransitioning) {
        self.yy_transitionContext = transitionContext
        if isBack {
            tierExecuteAnimationBack(using: transitionContext)
        } else {
            tierExecuteAnimation(using: transitionContext)
        }
    }
    
    func tierExecuteAnimation(using context: UIViewControllerContextTransitioning) {
        // 获取容器
        let containerView = context.containerView
        // 源view
        guard let fromView = context.view(forKey: .from) else {
            return
        }
        // 目标view
        guard let toView = context.view(forKey: .to) else {
            return
        }
        // 添加进容器
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        // 将目标view按比例缩放
        toView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        // 执行弹簧动画
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            // 源view移出
            fromView.transform = CGAffineTransform(translationX: -fromView.frame.size.width, y: 0)
            // 目标view恢复
            toView.transform = CGAffineTransform.identity
        }) { (finished) in
            // 源view恢复
            fromView.transform = CGAffineTransform.identity
            // 完成转场动画
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    func tierExecuteAnimationBack(using context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let fromView = context.view(forKey: .from) else {
            return
        }
        guard let toView = context.view(forKey: .to) else {
            return
        }
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        toView.transform = CGAffineTransform(translationX: -fromView.frame.size.width, y: 0)
        
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            fromView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            toView.transform = CGAffineTransform.identity
        }) { (finished) in
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
}


