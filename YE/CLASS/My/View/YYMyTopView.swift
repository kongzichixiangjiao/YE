//
//  YYMyTopView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/23.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYMyTopView: UIView {

    fileprivate let space: CGFloat = 10
    
    lazy var backImageView: UIImageView = {
        let v = UIImageView()
        v.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 240)
        v.image = UIImage.init(named: "IMG_1948")
        return v
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let v = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.light))
        v.frame = self.backImageView.bounds
        return v
    }()
    
    lazy var spaceView: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: self.backImageView.frame.size.height, width: self.backImageView.frame.size.width, height: 15)
        v.backgroundColor = UIColor.gray
        return v
    }()
    
    lazy var headerButton: UIButton = {
        let v = UIButton()
        let w: CGFloat = 65
        let x: CGFloat = self.center.x - w / 2
        let y: CGFloat = self.center.y - w / 2 - 40
        v.frame = CGRect(x: x, y: y, width: w, height: w)
        v.setImage(UIImage.init(named: "IMG_1948"), for: .normal)
        v.addTarget(self, action: #selector(clickedHeader(_:)), for: .touchUpInside)
        return v
    }()
    
    lazy var titleLabel: UILabel = {
        let v = UILabel()
        v.frame = CGRect(x: 0, y: self.headerButton.frame.origin.y + self.headerButton.frame.size.height + self.space, width: self.frame.size.width, height: 13)
        v.font = UIFont.systemFont(ofSize: 12)
        v.textColor = UIColor.white
        v.textAlignment = .center
        v.text = HuanXin.userId
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initBackViews()
        
        initViews()
        
    }
    
    @objc func clickedHeader(_ sender: UIButton) {
        
    }
    
    fileprivate func initViews() {
        self.addSubview(headerButton);
    }
    
    fileprivate func initBackViews() {
        self.addSubview(spaceView)
        self.addSubview(backImageView)
        self.addSubview(effectView)
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
