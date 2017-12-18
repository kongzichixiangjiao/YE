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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isHidden = true
        
        self.view.addSubview(self.tabbarView)
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
//        UIView.animate(withDuration: 0.35) {
//            self.tabbarView.frame = self.tabBar.frame
//        }
//        return
        tabbarView.isHidden = true
        tabbarView.alpha = 0
        UIView.animate(withDuration: 0.1, animations: {
            self.tabbarView.alpha = 1
        }) { (bo) in
            self.tabbarView.isHidden = false
        }
    }
    
    public func hideTabbarView(animation: Bool = true) {
//        UIView.animate(withDuration: 0.35) {
//            self.tabbarView.frame = CGRect(origin: CGPoint(x: 0, y: self.tabBar.frame.origin.y + self.tabBar.frame.height), size: CGSize(width: self.tabBar.frame.width, height: self.tabbarView.frame.height))
//        }
//        return
        
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
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didEndCustomizing viewControllers: [UIViewController], changed: Bool) {
    }

}
