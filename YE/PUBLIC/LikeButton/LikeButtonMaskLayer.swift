//
//  LikeButtonMaskLayer.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/29.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class LikeButtonMaskLayer: CAShapeLayer, CAAnimationDelegate {
    
    typealias Finished = () -> ()
    var finished: Finished!
    
    convenience init(bounds: CGRect, finished: @escaping Finished) {
        self.init()
        
        fillColor = UIColor.randomCGColor()
        strokeColor = UIColor.randomCGColor()
        lineWidth = 1.5
        
        self.finished = finished
    }
    
    public func startAnimation() {
        let anim = CAKeyframeAnimation(keyPath: KeyPath.path.rawValue)
        let fromPath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width, y: self.bounds.height / 2), radius: 1, startAngle: 0, endAngle: CGFloat(Double.pi) * 2.0, clockwise: false).cgPath
        let toPath = UIBezierPath(arcCenter: CGPoint(x: self.bounds.width, y: self.bounds.height / 2), radius: 15, startAngle: 0, endAngle: CGFloat(Double.pi) * 2.0, clockwise: false).cgPath
        anim.delegate = self
        anim.duration = 0.2
        anim.values = [fromPath, toPath]
        anim.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        self.add(anim, forKey: "path")
        
        let anim1 = CAKeyframeAnimation(keyPath: KeyPath.alpha.rawValue)
        let fromPath1 = 1
        let toPath1 = 0
        anim1.delegate = self
        anim1.duration = 0.3
        anim1.values = [fromPath1, toPath1]
        anim.autoreverses = false
        anim1.isRemovedOnCompletion = false
        self.add(anim1, forKey: "alhpa")
        
        let group = CAAnimationGroup()
        group.animations = [anim, anim1]
        group.duration = 0.3
        self.add(group, forKey: nil)
    }
    
    // MARK: CAAnimationDelegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        finished()
    }
}
