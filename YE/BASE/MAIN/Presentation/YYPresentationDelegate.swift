//
//  YYModalTransitionDelegate.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYPresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var presentationAnimationType: PresentationAnimationType = .none
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = GATransitionType.modalTransition(.present)
        return YYPresentationAnimationViewController(type: transitionType, presentationAnimationType: presentationAnimationType)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = GATransitionType.modalTransition(.dismiss)
        return YYPresentationAnimationViewController(type: transitionType, presentationAnimationType: presentationAnimationType)
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return YYPresentationController(presentedViewController: presented, presenting: presenting, type: presentationAnimationType)
    }
    
    convenience init(animationType: PresentationAnimationType = .none) {
        self.init()
        self.presentationAnimationType = animationType
    }
    
}