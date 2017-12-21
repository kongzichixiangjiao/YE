//
//  YYWaterView.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  水波纹、波浪效果

import UIKit

class YYWaterView: UIView {
    
    @IBInspectable var speed: CGFloat = 0 // 建议 1~10
    @IBInspectable var swingHeight: CGFloat = 20  // 不可以超过高或者
    @IBInspectable var palstance: CGFloat = 1  // 角速度 建议1~10
    @IBInspectable var waterWaveColor: UIColor = UIColor.blue
    @IBInspectable var directionType: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    convenience init(frame: CGRect, speed: CGFloat, swingHeight: CGFloat = 20, palstance: CGFloat = 1, waterWaveColor: UIColor = UIColor.blue, directionType: WaterDirectionType = .up) {
        self.init(frame: frame)
        
        self.speed = speed
        self.swingHeight = swingHeight
        self.waterWaveColor = waterWaveColor
        self.directionType = directionType.rawValue
    }
    
    enum WaterDirectionType: Int {
        case up = 1, down = 2, left = 3, right = 4
    }
    
    private var speedX: CGFloat = 0 //x轴移动速度
    private var A: CGFloat = 0 // 振幅 大于0 // 固定值
    private var ω: CGFloat = 0 // 角速度 大于0
    private var φ: CGFloat = Double.pi.cgFloat // 初始值
    private var k: CGFloat = 10 // 偏距
    //正弦曲线公式为： y=Asin(ωx+φ)+k
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.addSublayer(waterLayer)

        configData()
        
        displayLink.add(to: RunLoop.current, forMode: .commonModes)
    }
    
    private func configData() {
        switch WaterDirectionType(rawValue: directionType)! {
        case .up, .down:
            A = self.swingHeight >= self.bounds.height ? self.bounds.height : self.swingHeight
            k = self.bounds.height
            ω = palstance*Double.pi.cgFloat / self.bounds.width
            break
        case .left, .right:
            A = self.swingHeight >= self.bounds.width ? self.bounds.width : self.swingHeight
            k = self.bounds.width
            ω = Double.pi.cgFloat / self.bounds.height
            break
        }
        
        speedX = ω * speed
    }
    
    lazy var waterLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.frame = self.bounds
        layer.backgroundColor = UIColor.clear.cgColor
        return layer
    }()
    
    lazy var displayLink: CADisplayLink = {
        let link = CADisplayLink(target: self, selector: #selector(displayLinkAction))
        return link
    }()
    
    @objc func displayLinkAction() {
        self.update()
    }
    
    private func update() {
        _ = autoreleasepool { () -> CGMutablePath in
            self.φ += self.speedX
            var x: CGFloat = 0
            var y: CGFloat = 0
            let waterPath = CGMutablePath()
            
            switch WaterDirectionType(rawValue: directionType)! {
            case .up:
                waterPath.move(to: CGPoint(x: 0, y: 0))
                while x <= self.bounds.width {
                    y = self.A * sin(self.ω * x + self.φ) + self.A
                    waterPath.addLine(to: CGPoint(x: x, y: y))
                    x += 0.1
                }
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
                waterPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
                waterPath.addLine(to: CGPoint(x: 0, y: 0))
                break
            case .down:
                waterPath.move(to: CGPoint(x: 0, y: self.bounds.height))
                while x <= self.bounds.width {
                    y = self.A * sin(self.ω * x + self.φ) + k - self.A
                    waterPath.addLine(to: CGPoint(x: x, y: y))
                    x += 0.1
                }
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
                waterPath.addLine(to: CGPoint(x: 0, y: 0))
                waterPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
                break
            case .left:
                waterPath.move(to: CGPoint(x: 0, y: 0))
                while x <= self.bounds.height {
                    y = self.A * sin(self.ω * x + self.φ) + self.A
                    waterPath.addLine(to: CGPoint(x: y, y: x))
                    x += 0.1
                }
                waterPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: self.bounds.height))
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
                waterPath.addLine(to: CGPoint(x: 0, y: 0))
                break
            case .right:
                waterPath.move(to: CGPoint(x: 0, y: 0))
                waterPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
                while x <= self.bounds.height {
                    y = self.A * sin(self.ω * x + self.φ) + k - self.A
                    waterPath.addLine(to: CGPoint(x: y, y: x))
                    x += 0.1
                }
                waterPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
                waterPath.addLine(to: CGPoint(x: 0, y: 0))
                break
            }
            
            waterPath.closeSubpath()

            self.waterLayer.path = waterPath
            self.waterLayer.fillColor = self.waterWaveColor.cgColor
            return waterPath
        }
    }
    
    deinit {
        displayLink.remove(from: RunLoop.current, forMode: .commonModes)
        displayLink.invalidate()
    }
    
}
