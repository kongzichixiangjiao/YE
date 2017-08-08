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
                self.addConstraint(NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (self.text?.characters.count.cgFloat)! * self.yy_fontSize + 10))
                
                self.updateConstraintsIfNeeded()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupMyLabel()
    }
}

