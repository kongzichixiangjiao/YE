//
//  YYShotViewButton.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/13.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYShotViewButton: UIButton {

    typealias ClickedHandler = (_: Int)->()
    var clickedHandler: ClickedHandler?
    
    var mFrame: CGRect! {
        didSet {
            self.frame = mFrame
            initLineView(frame: mFrame)
        }
    }
    
    var isShowLineView: Bool! {
        didSet {
            self.lineView.isHidden = !isShowLineView
        }
    }
    
    var lineView: UIView!
    
    func initLineView(frame: CGRect) {
        lineView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1.0 / UIScreen.main.scale))
        lineView.backgroundColor = UIColor.lightGray
        self.addSubview(lineView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(title: String, tag: Int, handler: @escaping ClickedHandler) {
        self.init(frame: CGRect.zero)
        self.setTitle(title, for: .normal)
        self.tag = tag
        self.addTarget(self, action: #selector(action(sender: )), for: .touchUpInside)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setTitleColor(UIColor.white, for: .normal)
        self.clickedHandler = handler
    }
    
    func action(sender: UIButton) {
        self.clickedHandler!(sender.tag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
