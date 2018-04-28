//
//  YYProgressView.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/24.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYProgressView: UIView {

    var progress: Double = 0.0
    
    var fillColor: CGColor = UIColor.white.cgColor
    var strokeColor: CGColor = UIColor.white.cgColor
    
    lazy var fillLayer: CAShapeLayer = {
        let l = CAShapeLayer()
        return l
    }()
    
    lazy var strokeLayer: CAShapeLayer = {
        let l = CAShapeLayer()
        return l
    }()
    
    convenience init(frame: CGRect, progress: Double) {
        self.init(frame: frame)
        
        self.progress = progress
        
        initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func initViews() {
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}
