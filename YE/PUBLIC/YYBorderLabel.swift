//
//  YYBorderLabel.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  描边的label

import UIKit

//@IBDesignable
class YYBorderLabel: UILabel {
    
    @IBInspectable var yy_borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = yy_borderWidth
        }
    }
    
    @IBInspectable var yy_borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = yy_borderColor.cgColor
        }
    }
    @IBInspectable var yy_fontSize: CGFloat = 10 {
        didSet {
            self.font = UIFont.systemFont(ofSize: yy_fontSize)
        }
    }
    
    @IBInspectable var yy_spaceX: CGFloat = 0
    @IBInspectable var yy_spaceY: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMyLabel()
    }
    
    func setupMyLabel() {
        
        self.textAlignment = .center
        self.layer.borderWidth = self.yy_borderWidth
        self.layer.borderColor = self.yy_borderColor.cgColor
        self.layer.masksToBounds = true
        
        for layout in self.constraints {
            if (layout.firstItem as! NSObject == self && (layout.firstAttribute == NSLayoutAttribute.width)){
                self.removeConstraint(layout)
                self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat((self.text?.count)!) * self.yy_fontSize + yy_spaceX*2))
                
                self.updateConstraintsIfNeeded()
            }
            if (layout.firstItem as! NSObject == self && (layout.firstAttribute == NSLayoutAttribute.height)){
                self.removeConstraint(layout)
                self.addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.yy_fontSize + yy_spaceY*2))
                
                self.updateConstraintsIfNeeded()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupMyLabel()
    }
}

