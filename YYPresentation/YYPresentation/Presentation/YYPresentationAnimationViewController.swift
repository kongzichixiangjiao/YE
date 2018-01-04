//
//  YYPresentationAnimationViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit


class YYPresentationAnimationViewController: NSObject, UIViewControllerAnimatedTransitioning {
    private var transitionType: YYTransitionType
    private var presentationAnimationType: PresentationAnimationType
    
    init(type: YYTransitionType, presentationAnimationType: PresentationAnimationType = .downShow) {
        self.transitionType = type
        self.presentationAnimationType = presentationAnimationType
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.26
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from), let toVC = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        animationTransitionAllView(transitionContext: transitionContext, containerView: containerView, fromVC: fromVC, toVC: toVC)
    }
    
    func animationTransitionAllView(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromVC: UIViewController, toVC: UIViewController) {
        switch transitionType{
        case .modalTransition(let operation):
            switch operation {
            case .present:
                animationTransitionAllViewPresent(operation: operation, transitionContext: transitionContext, containerView: containerView, fromVC: fromVC, toVC: toVC)
                break 
            case .dismiss:
                animationTransitionAllViewDismiss(transitionContext: transitionContext, containerView: containerView, fromVC: fromVC, toVC: toVC)
                break
            }
        }
    }
    
    func animationTransitionAllViewDismiss(transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromVC: UIViewController, toVC: UIViewController) {
        let fromView = fromVC.view
        let toView = toVC.view
        
        switch presentationAnimationType {
        case .downShow:
            break
        case .upShow:
            break
        case .middle:
            animationTransitionWithMiddle(operation: .dismiss, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .none:
            break
        case .sheet:
            animationTransitionWithSheet(operation: .dismiss, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .alert:
            animationTransitionWithAlert(operation: .dismiss, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .bottom:
            animationTransitionWithBottom(operation: .dismiss, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .top:
            break
        }
    }
    
    func animationTransitionAllViewPresent(operation: ModalOperation, transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromVC: UIViewController, toVC: UIViewController) {
        let fromView = fromVC.view
        let toView = toVC.view
        
        switch presentationAnimationType {
        case .downShow:
            break
        case .upShow:
            break
        case .middle:
            animationTransitionWithMiddle(operation: .present, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .none:
            break
        case .sheet:
            animationTransitionWithSheet(operation: .present, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .alert:
            animationTransitionWithAlert(operation: .present, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .bottom:
            animationTransitionWithBottom(operation: .present, transitionContext: transitionContext, containerView: containerView, fromView: fromView, toView: toView)
            return
        case .top:
            break
        }
    }
    
    func animationTransitionWithAlert(operation: ModalOperation, transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView?, toView: UIView?) {
        guard let toView = toView, let fromView = fromView else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        switch operation {
        case .present:
            containerView.addSubview(toView)
            
            toView.subviews.first?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                toView.subviews.first?.transform = CGAffineTransform(scaleX: 1, y: 1)
            }) { (finished) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            break
        case .dismiss:
            containerView.addSubview(fromView)
            fromView.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0, y: 0)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        }
    }
    
    func animationTransitionWithMiddle(operation: ModalOperation, transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView?, toView: UIView?) {
        guard let toView = toView, let fromView = fromView else {
            return
        }
        
        switch operation {
        case .present:
            containerView.addSubview(toView)
            toView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.transform = CGAffineTransform.identity
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        case .dismiss:
            containerView.addSubview(fromView)
            fromView.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        }
    }
    func animationTransitionWithSheet(operation: ModalOperation, transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView?, toView: UIView?) {
        guard let toView = toView, let fromView = fromView else {
            return
        }
        let duration = transitionDuration(using: transitionContext)
        switch operation {
        case .present:
            containerView.addSubview(toView)
            toView.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
            
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                toView.transform = CGAffineTransform.identity
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        case .dismiss:
            containerView.addSubview(fromView)
            fromView.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                fromView.transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        }
    }
    
    func animationTransitionWithBottom(operation: ModalOperation, transitionContext: UIViewControllerContextTransitioning, containerView: UIView, fromView: UIView?, toView: UIView?) {
        guard let toView = toView, let fromView = fromView else {
            return
        }
        
        switch operation {
        case .present:
            containerView.addSubview(toView)
            toView.subviews.first?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                toView.subviews.first?.transform = CGAffineTransform.identity
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        case .dismiss:
            containerView.addSubview(fromView)
            fromView.subviews.first?.transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                fromView.subviews.first?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }, completion: { finished in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            break
        }
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        print("animationEnded")
    }
}

