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
    
    private let kCircleViewWidth: CGFloat = 5
    private let kCircleViewSpace: CGFloat = 7
    
    private let kCenterButtonWidth: CGFloat = 60
    private let kCenterButtonSpace: CGFloat = 20
    
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var topLineViewTopLayout: NSLayoutConstraint!
    
    @IBOutlet var textLabels: [UILabel]!
    
    weak var delegate: YYBaseTabBarViewDelegate!
    
    static func loadView() -> YYBaseTabBarView {
        return Bundle.main.loadNibNamed("YYBaseTabBarView", owner: self, options: nil)?.last as! YYBaseTabBarView
    }
    
    @IBAction func clickedAction(_ sender: UIButton) {
        self.circleView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.circleView.frame = CGRect(origin: CGPoint(x: self.textLabels[sender.tag].center.x - self.kCircleViewWidth / 2, y: self.textLabels[0].center.y + self.kCircleViewSpace), size: CGSize(width: self.kCircleViewWidth, height: self.kCircleViewWidth))
        }) {
            [weak self] bo in
            self?.delegate.clickedTabbar(selectedIndex: sender.tag)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topLineViewTopLayout.constant = 1 / UIScreen.main.scale
        self.circleView.frame = CGRect(origin: CGPoint(x: self.textLabels[0].center.x - kCircleViewWidth / 2, y: self.textLabels[0].center.y + kCircleViewSpace), size: CGSize(width: kCircleViewWidth, height: kCircleViewWidth))
        
        centerButton.frame = CGRect(x: self.center.x - kCenterButtonWidth / 2, y: -kCenterButtonSpace, width: kCenterButtonWidth, height: kCenterButtonWidth)
    }
    
    lazy var circleView: UIView = {
        let v = UIView(frame: CGRect.zero)
        v.backgroundColor = UIColor.orange
        v.layer.cornerRadius = kCircleViewWidth / 2
        v.layer.masksToBounds = true
        self.addSubview(v)
        return v
    }()
    
    lazy var centerButton: UIButton = {
        let b = UIButton()
        b.layer.cornerRadius = kCenterButtonSpace / 2
        b.layer.masksToBounds = true
        b.backgroundColor = UIColor.orange
        b.setTitle("野", for: .normal)
        b.setTitleColor(UIColor.black, for: .highlighted)
        b.addTarget(self, action: #selector(centerButtonAction), for: .touchUpInside)
        b.isUserInteractionEnabled = true
        self.addSubview(b)
        return b
    }()
    
    @objc func centerButtonAction() {
        self.circleView.isHidden = true
        self.circleView.frame = CGRect(origin: CGPoint(x: self.textLabels[2].center.x - self.kCircleViewWidth / 2, y: self.textLabels[2].center.y + self.kCircleViewSpace), size: CGSize(width: self.kCircleViewWidth, height: self.kCircleViewWidth))
        self.delegate.clickedTabbar(selectedIndex: 2)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let newPoint = self.convert(point, to: self.centerButton)
        if ((self.centerButton.hitTest(newPoint, with: event)) == self.centerButton) {
            return self.centerButton
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
    public func setupCircleView(tag: Int) {
        self.circleView.isHidden = tag == 2
        self.circleView.frame = CGRect(origin: CGPoint(x: self.textLabels[2].center.x - self.kCircleViewWidth / 2, y: self.textLabels[2].center.y + self.kCircleViewSpace), size: CGSize(width: self.kCircleViewWidth, height: self.kCircleViewWidth))
    }
    
}

