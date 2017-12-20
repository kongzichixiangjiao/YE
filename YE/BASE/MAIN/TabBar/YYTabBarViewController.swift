//
//  YYTabBarController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  自定义tabbar在iOS11上太坑了，感觉每次push再回来都将tabbar上的控件重置到最初 此坑填不上

import UIKit

class YYTabBarController: UITabBarController {

    static let identifier: String = "YYTabBarController"
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for v in self.tabBar.subviews {
            v.isHidden = true
        }
//        self.tabBar.removeFromSuperview()
//        self.view.insertSubview(self.tabbarView, at: 100)
    }

    lazy var tabbarView: YYBaseTabBarView = {
        let v = YYBaseTabBarView.loadView()
        v.frame = CGRect(x: 0, y: self.view.height - 49, width: self.view.width, height: 49)
        v.delegate = self
        return v
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func showTabbarView(animation: Bool = true) {
        tabbarView.frame = CGRect(x: 0, y: self.view.height - 49, width: self.view.width, height: 49)
        tabbarView.setupCircleView(tag: selectedIndex)
    }
    
    public func hideTabbarView(animation: Bool = true) {
        tabbarView.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: 49)
    }
}

extension YYTabBarController: YYBaseTabBarViewDelegate {
    func clickedTabbar(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
}

extension YYTabBarController: UITabBarControllerDelegate {

}
