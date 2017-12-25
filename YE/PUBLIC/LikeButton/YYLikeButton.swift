//
//  LikeButtonLayer.swift
//  GATransitionAnimation
//
//  Created by houjianan on 2017/3/28.
//  Copyright © 2017年 houjianan. All rights reserved.
//  一个点赞 喜欢 动画按钮

/*
 let like = LikeButton(frame: CGRect(x: 30, y: 200, width: 30, height: 30), clickedHandler: {
    print("start")
 })
 self.view.addSubview(like)
*/

import UIKit

class YYLikeButton: UIView {
    
    typealias ClickedHandler = () -> ()
    var clickedHandler: ClickedHandler!

    public var isSelected: Bool = false {
        didSet {
            imageLayer.backColor = (isSelected ? UIColor.orange : UIColor.blue).cgColor
        }
    }
    
    lazy var animationLayer: LikeButtonAnimationLayer = {
        let l = LikeButtonAnimationLayer(bounds: self.bounds)
        l.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        return l
    }()
    
    lazy var imageLayer: LikeButtonImageLayer = {
        let l = LikeButtonImageLayer(bounds: self.bounds)
        l.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        return l
    }()
    
    lazy var maskLayer: LikeButtonMaskLayer = {
        let l = LikeButtonMaskLayer(bounds: self.bounds, finished: {
            self.animationLayer.startAnimation()
        })
        l.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        l.opacity = 0 
        return l
    }()
    
    convenience init(frame: CGRect, clickedHandler: @escaping ClickedHandler) {
        self.init(frame: frame)
        self.clickedHandler = clickedHandler
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
        
        initLayer()
        addLayers()
    }
    
    private func addLayers() {
        self.layer.addSublayer(imageLayer)
        self.layer.addSublayer(maskLayer)
        self.layer.addSublayer(animationLayer)
    }
    
    private func initLayer() {
        self.bounds = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.layer.backgroundColor = UIColor.clear.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickedHandler()
        if !isSelected {
            maskLayer.startAnimation()
            imageLayer.startAnimation()
        }
        isSelected = !isSelected
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
