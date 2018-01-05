//
//  LikeButtonImageLayer.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/29.
//  Copyright © 2017年 houjianan. All rights reserved.
//

import UIKit

class LikeButtonImageLayer: CALayer {
    
    var backColor: CGColor = UIColor.black.cgColor {
        didSet {
            backgroundColor = backColor
        }
    }
    
    convenience init(bounds: CGRect) {
        self.init()
        self.bounds = bounds 
        let l  = CALayer()
        l.contents = UIImage(named: "star")?.cgImage
        l.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        l.bounds = bounds
        
        mask = l
        backgroundColor = UIColor.randomCGColor()
    }
    
    override init() {
        super.init()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    public func startAnimation() {
        let anim = CAKeyframeAnimation(keyPath: KeyPath.scale.rawValue)
        anim.duration  = 0.5
        anim.values = [0.4, 1, 0.9, 1]
        anim.calculationMode = kCAAnimationCubic
        self.add(anim, forKey: "scale")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
