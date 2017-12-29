//
//  YYTransition+Animation.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYTransition {

    func maskAnimation(targetVC: UIViewController, startPath: UIBezierPath, endPath: UIBezierPath, context: UIViewControllerContextTransitioning) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = endPath.cgPath
        targetVC.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = self.transitionDuration(using: context)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = self
        maskLayer.add(animation, forKey: "circle")
    }
    
}

