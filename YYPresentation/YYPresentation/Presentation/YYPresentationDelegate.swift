//
//  YYModalTransitionDelegate.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

open class YYPresentationDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    var presentationAnimationType: PresentationAnimationType = .none
    var isShowMaskView: Bool = false
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = YYTransitionType.modalTransition(.present)
        return YYPresentationAnimationViewController(type: transitionType, presentationAnimationType: presentationAnimationType)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transitionType = YYTransitionType.modalTransition(.dismiss)
        return YYPresentationAnimationViewController(type: transitionType, presentationAnimationType: presentationAnimationType)
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return YYPresentationController(presentedViewController: presented, presenting: presenting, type: presentationAnimationType, isShowMaskView: isShowMaskView)
    }
    
    convenience public init(animationType: PresentationAnimationType = .none, isShowMaskView: Bool = false) {
        self.init()
        self.presentationAnimationType = animationType
        self.isShowMaskView = isShowMaskView
    }
    
}
