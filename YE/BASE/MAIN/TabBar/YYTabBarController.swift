//
//  YYTabBarController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYTabBarController: UITabBarController {

    static let identifier: String = "YYTabBarController"
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.isHidden = true
        self.view.addSubview(tabbarView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    lazy var tabbarView: YYBaseTabBarView = {
        let v = YYBaseTabBarView.loadView()
        v.frame = self.tabBar.frame
        v.delegate = self
        return v
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func showTabbarView(animation: Bool = true) {
        tabbarView.isHidden = true
        tabbarView.alpha = 0
        UIView.animate(withDuration: 0.35, animations: {
            self.tabbarView.alpha = 1
        }) { (bo) in
            self.tabbarView.isHidden = false
        }
        
        self.tabbarView.frame = self.tabBar.frame
    }
    
    public func hideTabbarView(animation: Bool = true) {
        tabbarView.isHidden = false
        tabbarView.alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            self.tabbarView.alpha = 0
        }) { (bo) in
            self.tabbarView.isHidden = true
        }
    }
}

extension YYTabBarController: YYBaseTabBarViewDelegate {
    func clickedTabbar(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
}

extension YYTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabbarView.isHidden = true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
        print("2")
    }

}
