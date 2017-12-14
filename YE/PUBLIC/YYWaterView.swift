//
//  YYWaterView.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYWaterView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.blue
    }
    
    
    
    var k: CGFloat = 10 // 偏距
    var waterX: CGFloat = 0
    var ω: CGFloat = 10 // 角速度
    var waveMoveSpeed: CGFloat = 0 //x轴移动速度
    var φ: CGFloat = 0 // 初始值
    var A: CGFloat = 50 // 振幅
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        initWater()

        displayLink.add(to: RunLoop.current, forMode: .commonModes)
        
    }
    
    private func initWater() {
        self.layer.addSublayer(waterLayer)
    }
    
    lazy var waterLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.orange.cgColor
        layer.shadowPath = self.waterPath
        return layer
    }()
    
    lazy var waterPath: CGMutablePath = {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 50))
        var x: Int = 0
        var y: Int = 0
        path.addLine(to: CGPoint(x: x, y: y))
        
        for x in x...Int(self.bounds.width) {
            //正弦曲线公式为： y=Asin(ωx+φ)+k;
            y = Int(10 * sin(Double(10 * x + 2)) + 3)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        return path
    }()
    
    lazy var displayLink: CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(displayLinkAction))
        return link
    }()
    
    @objc func displayLinkAction() {
        let x: Int = 20
        var y: Int = Int(self.bounds.height)
        waterX += waveMoveSpeed * 3
        waterPath.move(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
        waterPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        waterPath.addLine(to: CGPoint(x: 0, y: 0))
        waterPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        //正弦曲线公式为： y=Asin(ωx+φ)+k;
        for x in x...Int(self.bounds.width) {
            
            
        }
        y = Int(Double(A) * sin(Double(Int(ω) * x + Int(φ)))) + Int(k)
        waterPath.addLine(to: CGPoint(x: x, y: y))
        waterPath.closeSubpath()

        waterLayer.path = waterPath
    }
    
    deinit {
        displayLink.remove(from: RunLoop.current, forMode: .commonModes)
        displayLink.invalidate()
    }
}
