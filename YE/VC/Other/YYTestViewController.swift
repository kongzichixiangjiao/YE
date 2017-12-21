//
//  YYTestViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  轮播图 展示

import UIKit
import Alamofire

class YYTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let circleScrollView = YYCircleScrollCollectionView(frame: CGRect(x: 20, y: 100, width: MainScreenWidth - 40, height: 300))
        self.view.addSubview(circleScrollView)
    }
    
    func myRequest() {
        
    }
    
}
