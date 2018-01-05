//
//  Toast.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/30.
//  Copyright © 2017年 houjianan. All rights reserved.
//  小toast

/*
 YYToast.ga.show()
 YYToast.ga.hide()
*/
import UIKit

class YYToast: CALayer {
    
    static let t: YYToast = YYToast()
    
    class var ga: YYToast {
        return t
    }
    
    lazy var strockLayer: CAShapeLayer? = {
        let l = CAShapeLayer()
        l.fillColor = UIColor.clear.cgColor
        l.strokeEnd = 1
        l.strokeColor = UIColor.randomCGColor()
        l.lineWidth = 6
        l.path = self.strockLayerPath()
        l.shouldRasterize = true
        l.rasterizationScale = UIScreen.main.scale
        l.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        return l
    }()
    
    lazy var electrocardiogramLayer: CAShapeLayer? = {
        
        let l = CAShapeLayer()
        l.fillColor = UIColor.clear.cgColor
        l.strokeEnd = 1
        l.strokeColor = UIColor.randomCGColor()
        l.lineWidth = 2
        l.path = self.electrocardiogramPath()
        l.shouldRasterize = true
        l.rasterizationScale = UIScreen.main.scale
        l.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        return l
    }()
    
    // MARK: Creat Path 
    private func strockLayerPath() -> CGPath {
        return UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 20, startAngle: CGFloat.GA_M_PI, endAngle: -CGFloat.GA_M_PI, clockwise: false).cgPath
    }
    
    private func electrocardiogramPath() -> CGPath {
        let w: CGFloat = self.bounds.width
        let h: CGFloat = self.bounds.height
        let leftSpace: CGFloat = 20
        let space: CGFloat = (w - 20 * 2) / 10
        let x: CGFloat = -w / 2 + leftSpace
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: -w / 2, y: 0))
        path.addLine(to: CGPoint(x: x, y: 0))
        path.addLine(to: CGPoint(x: x + space * 1, y: h / 5))
        path.addLine(to: CGPoint(x: x + space * 2, y: -h / 5))
        path.addLine(to: CGPoint(x: x + space * 3, y: h / 5))
        path.addLine(to: CGPoint(x: x + space * 4, y: -h / 3))
        path.addLine(to: CGPoint(x: x + space * 5, y: h / 3))
        path.addLine(to: CGPoint(x: x + space * 6, y: h / 5))
        path.addLine(to: CGPoint(x: x + space * 7, y: 0))
        path.addLine(to: CGPoint(x: w / 2, y: 0))
        
        return path.cgPath
    }
    
    // MARK: show()
    public func show() {
        self.isHidden = false
        startAnimation()
    }
    // MARK: hide()
    public func hide() {
        stopAnimation()
        self.isHidden = true
    }
    // MARK: startAnimation()
    private func startAnimation() {
        startAnimationStrock()
//        electrocardiogramAnimation()
    }
    // MARK: stopAnimation()
    private func stopAnimation() {
        stopAnimationStrock()
    }
    
    override init() {
        super.init()
        
        initLayer()
    }

    
    private func initLayer() {
        self.backgroundColor = UIColor.randomCGColor()
        
        self.shadowColor = UIColor.randomCGColor()
        self.shadowOffset = CGSize(width: 0, height: 0)
        self.shadowRadius = 2
        self.shadowOpacity = 0.5
        
        self.cornerRadius = 10
        
        self.position = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        self.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        UIApplication.shared.windows.first?.layer.addSublayer(self)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("over")
    }
    
    // 心电图动画
    private func electrocardiogramAnimation() {
        self.addSublayer(electrocardiogramLayer!)
        
        let strokeEndAnimation = addAnimation(duration: 1, fromValue: 0, toValue: 1, keyPath: "strokeEnd", handler: {
            animation in
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        })
        
        electrocardiogramLayer?.add(strokeEndAnimation, forKey: nil)
    }
    
    private func startAnimationStrock() {
        
        self.addSublayer(strockLayer!)
        
        let strokeEndAnimation = addAnimation(duration: 1, fromValue: 0, toValue: 1, keyPath: "strokeEnd", handler: {
            animation in
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        })
        
        let strokeStartAnimation = addAnimation(duration: 1, fromValue: 0, toValue: 1, keyPath: "strokeStart", handler: {
            animation in
            animation.beginTime = 0.8 // 调整画出圈的周长
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        })

        // duration控制旋转时间间隔（小开口的位置）
        let rotaionZAnimation = addAnimation(duration: 0.5, fromValue: 0, toValue: CGFloat.GA_M_2PI, keyPath: "transform.rotation.z", handler: nil)

        let group = CAAnimationGroup()
        // 控制每次圈圈出来之间的时间间隔
        group.duration = strokeEndAnimation.duration + 0.2
        group.animations = [strokeStartAnimation, strokeEndAnimation]
        group.repeatCount = MAXFLOAT
        // 分开add到layer是为了单独控制旋转动画时间
        strockLayer?.add(group, forKey: nil)
        strockLayer?.add(rotaionZAnimation, forKey: nil)
    }
    
    private func addAnimation<T: Any>(duration: Double = 2, fromValue: T, toValue: T, isRepeat: Bool = true, keyPath: String, handler: ((_ a: CABasicAnimation) -> ())?) -> CABasicAnimation  {
        let morph = CABasicAnimation(keyPath: keyPath)
        morph.duration = duration
        morph.fromValue = fromValue
        morph.toValue = toValue
        morph.repeatCount = isRepeat ? MAXFLOAT : 1
        handler?(morph)
        return morph
    }
    
    private func stopAnimationStrock() {
        
    }
    
}

extension YYToast: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        //        print("start")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //        print("stop")
    }
    
}

