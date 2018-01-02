//
//  YYPresentationAnimationViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYPresentationAnimationViewController: NSObject, UIViewControllerAnimatedTransitioning {
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
        
        var translation: CGFloat = 0
        var fromViewTransform = CGAffineTransform.identity
        var toViewTransform = CGAffineTransform.identity
        
        switch transitionType{
        case .modalTransition(let operation):
            switch operation {
            case .present:
                
                switch presentationAnimationType {
                case .downShow:
                    translation = containerView.frame.width
                    toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
                    fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
                    break
                case .upShow:
                    translation = -containerView.frame.height
                    toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
                    fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
                    break
                case .middle:
                    translation = 0
                    toViewTransform = CGAffineTransform(scaleX: 0.2, y: 0.2)
                    break
                case .none:
                    translation = 0
                    toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
                    fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
                    break
                case .sheet:
                    translation = containerView.frame.width
                    toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
                    fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
                    break
                case .alert:
                    translation = 0
                    toViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? translation : 0))
                    fromViewTransform = CGAffineTransform(translationX: 0, y: (operation == .present ? 0 : translation))
                    break
                }
                containerView.addSubview(toView!)
                
                toView?.transform = toViewTransform
                
                if presentationAnimationType == .alert {
                    toView?.alpha = 0
                    UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                        toView?.alpha = 1
                    })
                }
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromView?.transform = fromViewTransform
                    toView?.transform = CGAffineTransform.identity
                }, completion: { finished in
                    fromView?.transform = CGAffineTransform.identity
                    toView?.transform = CGAffineTransform.identity
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
                
            case .dismiss:
                switch presentationAnimationType {
                case .downShow:
                    break
                case .upShow:
                    break
                case .middle:
                    toViewTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                    break
                case .none:
                    break
                case .sheet:
                    break
                case .alert:
                    break
                }
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromView?.transform = toViewTransform
//                    toView?.transform = toViewTransform
                }, completion: { finished in
//                    fromView?.transform = fromViewTransform
//                    toView?.transform = toViewTransform
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
                break
            }
        default: containerView.addSubview(toView!)
        }
        
    }
    
    private func present() {
        
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        print("animationEnded")
    }
}

