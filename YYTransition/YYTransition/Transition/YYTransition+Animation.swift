//
//  YYTransition+Animation.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYTransition where Base: UIViewController {

    func maskAnimation(targetVC: UIViewController, startPath: UIBezierPath, endPath: UIBezierPath, context: UIViewControllerContextTransitioning) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = endPath.cgPath
        targetVC.view.layer.mask = maskLayer
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = base.transitionDuration(using: context)
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.delegate = base
        maskLayer.add(animation, forKey: "circle")
    }
    
}

