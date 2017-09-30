//
//  YYAlertAnimation.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
// MARK: 动画
extension UIView {
    
    fileprivate func loadingViewAnimation(_ v: UIView) {
        let b          = CABasicAnimation(keyPath: KeyPath.z.rawValue)
        
        b.fromValue    = 0
        b.toValue      = CGFloat.GA_M_2PI
        b.duration     = 0.8
        b.repeatCount  = MAXFLOAT
        b.autoreverses = true
        
        v.layer.add(b, forKey: "");
    }
    
    func showAnimation(_ view: UIView, isWhiteWindow: Bool = false) {
        let basicAnimation          = CABasicAnimation(keyPath: KeyPath.scale.rawValue)
        basicAnimation.fromValue    = 0
        basicAnimation.toValue      = 0.8
        basicAnimation.autoreverses = false
        basicAnimation.duration     = 0.2
        view.layer.add(basicAnimation, forKey: "")
        if isWhiteWindow {
            self.alertWhiteWindow.addSubview(view)
        } else {
            self.alertWindow.addSubview(view)
        }
    }
    
    func hideAnimation(_ view: UIView) {
        let basicAnimation          = CABasicAnimation(keyPath: KeyPath.scale.rawValue)
        basicAnimation.delegate     = self;
        basicAnimation.fromValue    = 1
        basicAnimation.toValue      = 0
        basicAnimation.autoreverses = false
        basicAnimation.duration     = 0.2
        view.layer.add(basicAnimation, forKey: "")
    }
    
    fileprivate func remove() {
        self.activity.removeFromSuperview()
        self.toastView.removeFromSuperview()
        objc_setAssociatedObject(self, &YYAlertKey.kToastView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &YYAlertKey.kActivity, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

extension UIView: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        print("start")
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        remove()
    }
}
