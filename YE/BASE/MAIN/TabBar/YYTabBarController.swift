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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tabbarView)
    }
    
    lazy var tabbarView: YYBaseTabBarView = {
        let v = Bundle.main.loadNibNamed("YYBaseTabBarView", owner: self, options: nil)?.last as! YYBaseTabBarView
        v.frame = self.tabBar.frame
        v.backgroundColor = UIColor.orange
        return v
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    public func showTabbarView() {
        tabbarView.isHidden = false
    }
    
    public func hideTabbarView() {
        tabbarView.isHidden = true
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
