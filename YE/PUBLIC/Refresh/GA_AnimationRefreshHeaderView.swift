//
//  GA_AnimationRefreshHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class GA_AnimationRefreshHeaderView: GA_XIBRefreshHeaderView {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func startAnimation() {
        super.startAnimation()
        self.activityView.startAnimating()
        self.stateLabel.text = "开始加载"
    }
    
    override func stopAnimation() {
        super.stopAnimation()
        self.activityView.stopAnimating()
        self.stateLabel.text = "向下拉"
    }
    
    override func animationing() {
        super.animationing()
        self.stateLabel.text = "加载ing"
    }
    
    override func willAnimation() {
        super.willAnimation()
        self.stateLabel.text = "松手加载"
    }
    
    override func pullAnimation() {
        super.pullAnimation()
        self.stateLabel.text = "向下拉..."
    }
}
