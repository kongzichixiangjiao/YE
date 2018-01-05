//
//  LikeButtonAnimationLayer.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/29.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class LikeButtonAnimationLayer: CALayer {
    
    public var circleCount: Int = 6
    
    var circle = [CAShapeLayer]()
    var circleSmall = [CAShapeLayer]()
    
    convenience init(bounds: CGRect) {
        self.init()
        self.bounds = bounds
        self.backgroundColor = UIColor.clear.cgColor
        initCircle(isSmall: true)
        initCircle(isSmall: false)
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCircle(isSmall: Bool) {
        for i in 0..<circleCount {
            let shaper = CAShapeLayer()
            shaper.fillColor = UIColor.randomCGColor()
            shaper.strokeColor = UIColor.randomCGColor()
            shaper.lineWidth = 0
            shaper.lineJoin = kCALineJoinMiter
            shaper.lineCap = kCALineCapRound
            shaper.path = getPath(count: i, isSmall: isSmall).cgPath
            shaper.opacity = 0
            self.addSublayer(shaper)
            
            if isSmall {
                circleSmall.append(shaper)
            } else {
                circle.append(shaper)
            }
        }
    }
    
    private func getPath(count: Int, isSmall: Bool) -> UIBezierPath {
        let angle = CGFloat.GA_M_PI * 2 / CGFloat(circleCount)
        
        let x: CGFloat = cos(angle * CGFloat(count)) * 10 + self.bounds.width / 2 + (isSmall ? CGFloat.GA_M_PI / CGFloat(circleCount) : 0)
        let y: CGFloat = sin(angle * CGFloat(count)) * 10 + self.bounds.height / 2 + (isSmall ? CGFloat.GA_M_PI / CGFloat(circleCount) : 0)
        
        let path = UIBezierPath(arcCenter: CGPoint(x: x, y: y), radius: (isSmall ? 1.8 : 2.5), startAngle: CGFloat.GA_M_PI * 2, endAngle: 0, clockwise: false)
        
        return path
    }
    
    private func animation(_ layer: CAShapeLayer, i: Int, isSmall: Bool = false) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        let angle = CGFloat.GA_M_PI * 2 / CGFloat(circleCount)
        
        let x: CGFloat = cos((angle * CGFloat(i)) + (isSmall ? CGFloat.GA_M_PI / CGFloat(circleCount) : 0)) * 20
        let y: CGFloat = sin((angle * CGFloat(i)) + (isSmall ? CGFloat.GA_M_PI / CGFloat(circleCount) : 0)) * 20
        
        bezierPath.addLine(to: CGPoint(x: x, y: y))
        
        /*
        // 方便观察路径
        // 这里的路径有错误但是效果没错??!?
        let shaper = CAShapeLayer()
        shaper.fillColor = UIColor.clear.cgColor
        shaper.strokeColor = UIColor.randomCGColor()
        shaper.lineWidth = 1
        shaper.lineJoin = kCALineJoinMiter
        shaper.lineCap = kCALineCapRound
        shaper.path = bezierPath.cgPath
        self.addSublayer(shaper)
         */
 
        let animation         = CAKeyframeAnimation(keyPath: KeyPath.position.rawValue)

        animation.values = [layer
            .position, CGPoint(x: x, y: y)]
        animation.duration    = 0.4
        animation.repeatCount = 1
        
        let animation1         = CAKeyframeAnimation(keyPath: KeyPath.alpha.rawValue)
        animation1.duration    = 0.4
        animation1.values = [1, 1, 0]
        animation1.repeatCount = 1
        
        let group = CAAnimationGroup()
        group.animations = [animation, animation1]
        group.duration = 0.4
        layer.add(group, forKey: nil)
    }
    
    public func startAnimation() {
        for i in 0..<circleCount {
            animation(circle[i], i: i + 1)
            animation(circleSmall[i], i: i + 1, isSmall: true)
        }
    }
}
