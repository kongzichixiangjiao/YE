//
//  GA_CircleRefreshHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class aaa<T>: UIView {
    
}

class GA_CircleRefreshHeaderView: GA_RefreshHeaderView {
    
    private let kShaperHeight: CGFloat = 35
    
    fileprivate let kRotationAnimation = "kRotationAnimation"
    
    fileprivate let shapeLayer = CAShapeLayer()
    fileprivate lazy var identityTransform: CATransform3D = {
        var transform = CATransform3DIdentity
        transform.m34 = CGFloat(1.0 / -500.0)
        transform = CATransform3DRotate(transform, CGFloat(-90.0).toRadians(), 0.0, 0.0, 1.0)
        return transform
    }()
    
    init() {
        super.init(frame: CGRect(x: 0, y: -64, width: MainScreenWidth, height: 64))
        self.frame = CGRect(x: 0, y: -64, width: MainScreenWidth, height: 64)
        self.backgroundColor = UIColor.yellow
        shapeLayer.lineWidth = 2.0
        shapeLayer.fillColor = UIColor.orange.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.strokeEnd = 0.9
        shapeLayer.actions = ["strokeEnd" : NSNull(), "transform" : NSNull()]
        shapeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        layer.addSublayer(shapeLayer)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Methods
    override func startAnimation() {
        super.startAnimation()
        
        if shapeLayer.animation(forKey: kRotationAnimation) != nil { return }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
//        rotationAnimation.toValue = CGFloat(2 * Double.pi) + currentDegree()
        rotationAnimation.toValue = CGFloat(2 * Double.pi)
        rotationAnimation.duration = 1.0
        rotationAnimation.repeatCount = Float.infinity
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = kCAFillModeForwards
        shapeLayer.add(rotationAnimation, forKey: kRotationAnimation)
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        shapeLayer.removeAnimation(forKey: kRotationAnimation)
    }
    
    override func pullAnimation() {
        super.pullAnimation()
        willShaperAnimation()
    }
    
    override func willAnimation() {
        super.willAnimation()
        willShaperAnimation()
    }
    
    private func willShaperAnimation() {
        let scrollView = self.superview as! UIScrollView
        let newY = scrollView.contentOffset.y
        let progress = abs(newY / RefreshKey.kContentInsetTop)
        shapeLayer.strokeEnd = min(0.9 * progress, 0.9)
        
        if progress > 1.0 {
            let degrees = ((progress - 1.0) * 200.0)
            shapeLayer.transform = CATransform3DRotate(identityTransform, degrees.toRadians(), 0.0, 0.0, 1.0)
        } else {
            shapeLayer.transform = identityTransform
        }
    }
    
    fileprivate func currentDegree() -> CGFloat {
        return shapeLayer.value(forKeyPath: "transform.rotation.z") as! CGFloat
    }
    
    override open func tintColorDidChange() {
        super.tintColorDidChange()
        
        shapeLayer.strokeColor = tintColor.cgColor
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.frame = CGRect(x: MainScreenWidth / 2 - kShaperHeight / 2, y: kShaperHeight / 2 - kShaperHeight / 2, width: kShaperHeight, height: kShaperHeight)
        
        let inset = shapeLayer.lineWidth / 2.0

        shapeLayer.path = UIBezierPath(ovalIn: shapeLayer.bounds.insetBy(dx: inset, dy: inset)).cgPath
        
    }
}
