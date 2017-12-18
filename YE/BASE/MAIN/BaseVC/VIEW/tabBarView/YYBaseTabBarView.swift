//
//  YYTabBarView.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

protocol YYBaseTabBarViewDelegate: NSObjectProtocol {
    func clickedTabbar(selectedIndex: Int)
}

class YYBaseTabBarView: UIView {
    
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var topLineViewTopLayout: NSLayoutConstraint!
    
    weak var delegate: YYBaseTabBarViewDelegate!

    static func loadView() -> YYBaseTabBarView {
        return Bundle.main.loadNibNamed("YYBaseTabBarView", owner: self, options: nil)?.last as! YYBaseTabBarView
    }
    
    @IBAction func clickedAction(_ sender: UIButton) {
        delegate.clickedTabbar(selectedIndex: sender.tag - 1)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLineViewTopLayout.constant = 1 / UIScreen.main.scale
    }
}
