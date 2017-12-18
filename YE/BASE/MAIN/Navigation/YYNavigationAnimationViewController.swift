//
//  GA_AnimationViewController.swift
//  GA_TransitionAnimation
//
//  Created by houjianan on 2017/3/16.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

enum GATransitionType{
    case navigationTransition(UINavigationControllerOperation)
    case tabTransition(TabOperationDirection)
    case modalTransition(ModalOperation)
}

enum TabOperationDirection{
    case left, right    
}


class YYNavigationAnimationViewController: NSObject, UIViewControllerAnimatedTransitioning {
    private var transitionType: GATransitionType
    private var presentationAnimationType: PresentationAnimationType
    
    init(type: GATransitionType, presentationAnimationType: PresentationAnimationType = .downShow) {
        self.transitionType = type
        self.presentationAnimationType = presentationAnimationType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        let fromView = fromVC.view
        let toView = toVC.view
        
        var translation = containerView.frame.width
        var fromViewTransform = CGAffineTransform.identity
        var toViewTransform = CGAffineTransform.identity
        
        switch transitionType {
        case .navigationTransition(let operation):
            translation = operation == .push ? translation : 0
            fromViewTransform = CGAffineTransform(scaleX: -translation, y: 0)
            toViewTransform = CGAffineTransform(scaleX: translation, y: 0)
        case .tabTransition(let direction):
            translation = direction == .left ? translation : -translation
            fromViewTransform = CGAffineTransform(translationX: translation, y: 0)
            toViewTransform = CGAffineTransform(translationX: -translation, y: 0)
            
        case .modalTransition(let operation):
            translation =  containerView.frame.height
            toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
            fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
        }
        
        containerView.addSubview(toView!)

        toView?.transform = toViewTransform
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView?.transform = fromViewTransform
            toView?.transform = CGAffineTransform.identity
        }, completion: { finished in
            fromView?.transform = CGAffineTransform.identity
            toView?.transform = CGAffineTransform.identity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        
    }
    
}

