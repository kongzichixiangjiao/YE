//
//  YYMainRootViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/20.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYMainRootViewController: UIViewController {
    
    var vcs: [UIViewController] = []
    var currentPage: Int = 99
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for vc in childViewControllers {
            (vc as! YYNavigationViewController).yy_tabBarController = self
        }
        
        transition(toPage: 0)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        for vc in childViewControllers {
            vc.view.frame = self.view.bounds
        }
        
        self.view.addSubview(self.tabbarView)
        tabbarView.frame = CGRect(x: 0, y: self.view.height - TabBarHeight, width: self.view.width, height: TabBarHeight)
    }
    
    private func transition(toPage: Int) {
        if currentPage == toPage {
            return 
        }
        vcs = self.childViewControllers
        
        for vc in vcs {
            if vc.view.alpha == 1 {
                vc.viewWillDisappear(true)
                vc.view.alpha = 0
                vc.view.isHidden = true
                vc.viewDidDisappear(true)
            }
        }
        
        let newController = vcs[toPage]
        newController.viewWillAppear(true)
        newController.view.isHidden = false
        self.view.insertSubview(newController.view, belowSubview: tabbarView)
        newController.viewDidAppear(true)
        
        UIView.animate(withDuration: 0.3, animations: {
            newController.view.alpha = 1
        }) { (bo) in
            self.currentPage = toPage
        }
    }
    
    lazy var tabbarView: YYBaseTabBarView = {
        let v = YYBaseTabBarView.loadView()
        v.delegate = self
        return v
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func showTabbarView(animation: Bool = true) {
        if !animation {return}
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
            self.tabbarView.centerButton.isHidden = true
            self.tabbarView.frame = CGRect(x: 0, y: self.view.height - 49, width: self.view.width, height: 49)
            self.tabbarView.centerButton.alpha = 1
        }) { (bo) in
            self.tabbarView.centerButton.isHidden = false
        }
    }
    
    public func hideTabbarView(animation: Bool = true) {
        if !animation {return}
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
            self.tabbarView.centerButton.isHidden = false
            self.tabbarView.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: 49)
            self.tabbarView.centerButton.alpha = 0
        }) { (bo) in
            self.tabbarView.centerButton.isHidden = true
        }
    }
    
}

extension YYMainRootViewController: YYBaseTabBarViewDelegate {
    func clickedTabbar(selectedIndex: Int) {
        transition(toPage: selectedIndex)
    }
}

