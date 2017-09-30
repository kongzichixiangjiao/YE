//
//  YYIMBaseViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/17.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMBaseMessageViewController: EaseMessageViewController {
    
    var imTitle: String! {
        didSet {
            navigationView.myTitle = imTitle
        }
    }
    
    lazy var navigationView: YYBaseNavigationView = {
        let v = YYBaseNavigationView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: YYBaseNavigationView.height))
        v.myDelegate = self
        self.view.addSubview(v)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsets(top: YYBaseNavigationView.height, left: 0, bottom: 0, right: 0)
        self.showRefreshHeader = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func initNavigationView(_ title: String, _ isHiddenLeftButton: Bool = false) {
        navigationView.myTitle = "首页"
        navigationView.isHiddenLeftButton = isHiddenLeftButton
    }
    
    func clickedLeftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickedRightButtonAction(_ sender: UIButton) {
        
    }
    
}


extension YYIMBaseMessageViewController: YYBaseNavigationViewProtocol {
    func back() {
        self.clickedLeftButtonAction()
    }
    
    func back(_ model: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickedNavigationViewRightButton(_ sender: UIButton) {
        clickedRightButtonAction(sender)
    }
}
