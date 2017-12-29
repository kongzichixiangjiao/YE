//
//  YYTransition+Middle.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYTransition {
    
    func middleAnimationTransition(isBack: Bool, using transitionContext: UIViewControllerContextTransitioning) {
        self.yy_transitionContext = transitionContext
        if isBack {
            middleAnimationTransitionBack(using: transitionContext)
        } else {
            middleAnimationTransition(using: transitionContext)
        }
    }
    
    func middleAnimationTransition(using context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let fromVC = context.viewController(forKey: .from) else {
            return
        }
        guard let toVC = context.viewController(forKey: .to) else {
            return
        }
        let fromView = fromVC.view
        let toView = toVC.view
        
        containerView.addSubview(toView!)
        containerView.addSubview(fromView!)
        
        let startPath = UIBezierPath(ovalIn: fromView!.frame)
        let endPath = UIBezierPath(ovalIn: CGRect(x: toView!.center.x, y: toView!.center.y, width: 0, height: 0))
        
        maskAnimation(targetVC: fromVC, startPath: startPath, endPath: endPath, context: context)
    }
    
    func middleAnimationTransitionBack(using context: UIViewControllerContextTransitioning) {let containerView = context.containerView
        guard let fromVC = context.viewController(forKey: .from) else {
            return
        }
        guard let toVC = context.viewController(forKey: .to) else {
            return
        }
        let fromView = fromVC.view
        let toView = toVC.view
        
        containerView.addSubview(fromView!)
        containerView.addSubview(toView!)
        
        let startPath = UIBezierPath(ovalIn: CGRect(x: toView!.center.x, y: toView!.center.y, width: 0, height: 0))
        let endPath = UIBezierPath(ovalIn: fromView!.frame)
        
        maskAnimation(targetVC: toVC, startPath: startPath, endPath: endPath, context: context)
    }
}
