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
    
    @IBOutlet var textLabels: [UILabel]!
    
    weak var delegate: YYBaseTabBarViewDelegate!
    
    static func loadView() -> YYBaseTabBarView {
        return Bundle.main.loadNibNamed("YYBaseTabBarView", owner: self, options: nil)?.last as! YYBaseTabBarView
    }
    
    @IBAction func clickedAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.circleView.frame = CGRect(origin: CGPoint(x: self.textLabels[sender.tag].center.x, y: self.textLabels[0].center.y + 5), size: CGSize(width: 10, height: 10))
        }) {
            [weak self] bo in
            self?.delegate.clickedTabbar(selectedIndex: sender.tag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    lazy var circleView: UIView = {
        let v = UIView(frame: CGRect.zero)
        v.backgroundColor = UIColor.orange
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        self.addSubview(v)
        return v
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLineViewTopLayout.constant = 1 / UIScreen.main.scale
        self.circleView.frame = CGRect(origin: CGPoint(x: self.textLabels[0].center.x, y: self.textLabels[0].center.x + 5), size: CGSize(width: 10, height: 10))
    }
}

