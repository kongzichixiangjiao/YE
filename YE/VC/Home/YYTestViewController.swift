//
//  YYTestViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Alamofire

class YYTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let circleScrollView = YYCircleScrollCollectionView(frame: CGRect(x: 20, y: 100, width: MainScreenWidth - 40, height: 300))
        self.view.addSubview(circleScrollView)
        
        let autoScrollView = YYAutoScrollView(frame: CGRect(x: 10, y: 350, width: MainScreenWidth - 20, height: 100))
        autoScrollView.backgroundColor = UIColor.orange
        self.view.addSubview(autoScrollView)
    }
    
    func myRequest() {
        
    }
    
}
