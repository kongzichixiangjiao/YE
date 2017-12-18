//
//  YYNavigationControllerDelegate.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation


// storyboard里拖拽Object设置class为YYNavigationViewControllerDelegate 并且连线navigationcontroller
class YYNavigationViewControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    var interactive: Bool = false
    // 控制转场
    weak var interactiveTransition = UIPercentDrivenInteractiveTransition()
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YYNavigationAnimationViewController(type: GATransitionType.navigationTransition(operation))
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactiveTransition : nil
    }
    
    func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        return UIInterfaceOrientation(rawValue: 0)!
    }
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    }
}

