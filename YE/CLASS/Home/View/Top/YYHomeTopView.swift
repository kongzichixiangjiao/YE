//
//  YYEventTopView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYHomeTopView: YYBaseView {

    var didSelectItemAtHandler: YYModuleSelectedView.DidSelectItemAtHandler?
    
    var imageNames: [String]? {
        didSet {
            initCircleScrollView()
        }
    }
    
    var data: [[String : Any]]? {
        didSet {
            initModuleSelectedView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init(frame: CGRect, handler: @escaping YYModuleSelectedView.DidSelectItemAtHandler) {
        self.init(frame: frame)
        self.didSelectItemAtHandler = handler
    }
    
    func initViews() {
        initCircleScrollView()
        initModuleSelectedView()
    }
    
    func initCircleScrollView() {
        let circleView = YYCircleScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: kYYCircleScrollViewHeight), isTimer: false)
        circleView.backgroundColor = UIColor.lightGray
        self.addSubview(circleView)
        circleView.scArray = self.imageNames
    }
    
    func initModuleSelectedView() {
        let v = YYModuleSelectedView(frame: CGRect(x: 0, y: kYYCircleScrollViewHeight, width: self.frame.size.width, height: kYYModuleSelectedCellHeight)) {
            [weak self] row in
            if let weakSelf = self {
                weakSelf.didSelectItemAtHandler?(row)
            }
        }
        self.addSubview(v)
        v.data = self.data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
