//
//  YYPlayerGradualChangeView.swift
//  YYPlayer
//
//  Created by 侯佳男 on 2018/5/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

// MARK: YYPlayerGradualChangeView 渐变视图
public class YYPlayerGradualChangeView: UIView {
    
    @IBInspectable var isUpDeep: Bool = false
    
    var gradientLayer: CAGradientLayer?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let gradientLayer = initGradientLayer()
        self.layer.addSublayer(gradientLayer)
        gradientLayer.frame = self.layer.bounds
    }
    
    func initGradientLayer() -> CAGradientLayer {
        if let g = gradientLayer {
            return g
        }
        let g = CAGradientLayer()
        let colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor,
            ]
        let locations = [
            0.0, 1
        ]
        g.colors = colors
        g.locations = locations as [NSNumber]
        let startPoint = self.isUpDeep ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0.5, y: 1)
        let endPoint = self.isUpDeep ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 0.5, y: 0)
        g.startPoint = startPoint
        g.endPoint = endPoint
        
        gradientLayer = g
        
        return g
    }
}

