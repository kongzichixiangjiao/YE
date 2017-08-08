//
//  YYIconLableView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  icon+文字

import UIKit

enum IconPosition: Int {
    case left = 0, top = 1
}

class YYIconLableView: UIView {

    @IBInspectable var iconPosition: Int = 0
    @IBInspectable var icon: String = ""
    @IBInspectable var iconScale: CGFloat = 0.6 // ...
    @IBInspectable var content: String = ""
    @IBInspectable var space: CGFloat = 0
    @IBInspectable var contentColor: UIColor = UIColor.lightText
    @IBInspectable var contentFontSize: CGFloat = 9
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
        
    }
    
    lazy var iconImageView: UIImageView = {
        let v = UIImageView()
        let image = UIImage(named: self.icon)
        let imageW: CGFloat = image!.width * self.iconScale
        let imageH: CGFloat = image!.height * self.iconScale
        if self.iconPosition == IconPosition.left.rawValue {
            v.frame = CGRect(x: 0, y: self.height / 2 - imageH / 2, width: imageW, height: imageH)
        } else {
            v.frame = CGRect(x: self.width / 2 - imageW / 2, y: 0, width: imageW, height: imageH)
        }
        v.image = image
        self.addSubview(v)
        return v
    }()
    
    lazy var contentLable: UILabel = {
        let v = UILabel()
        if self.iconPosition == IconPosition.left.rawValue {
            v.frame = CGRect(x: self.iconImageView.maxX + self.space, y: self.height / 2 - self.contentFontSize / 2, width: self.content.ga_widthWith(fontSize: self.contentFontSize, height: self.contentFontSize), height: self.contentFontSize)
        } else {
            let w: CGFloat = self.content.ga_widthWith(fontSize: self.contentFontSize, height: self.contentFontSize)
            v.frame = CGRect(x: self.width / 2 - w / 2, y: self.iconImageView.maxY + self.space, width: w, height: self.contentFontSize)
            v.textAlignment = .center
        }
        v.font = UIFont.systemFont(ofSize: self.contentFontSize)
        v.textColor = self.contentColor
        v.text = self.content
        self.addSubview(v)
        return v
    }()
    
    private func initViews() {
        if self.iconPosition == IconPosition.left.rawValue {
            self.bounds = CGRect(x: 0, y: 0, width: self.iconImageView.width + space + self.contentLable.width, height: Compare.ga_MAX(self.iconImageView.height, self.contentLable.height))
        } else {
            self.bounds = CGRect(x: 0, y: 0, width: Compare.ga_MAX(self.iconImageView.width, self.contentLable.width), height: self.iconImageView.height + space + self.contentLable.height)
        }
    }
    


}
