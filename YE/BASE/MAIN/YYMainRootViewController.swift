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
    var old: Int = 0
    var isFinished: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for vc in childViewControllers {
            (vc as! YYNavigationViewController).yy_tabBarController = self
        }
        
        vcs = self.childViewControllers
        
        self.view.addSubview(self.tabbarView)
        
        transition(to: 0)
    }
    
    private func transition(to: Int) {
        if old == to {
            return 
        }
        vcs = self.childViewControllers
        
        print(self.childViewControllers)
        print(old, to, vcs[old], vcs[to])
        let newController = vcs[to]
        let oldController = vcs[old]

        self.view.insertSubview(newController.view, belowSubview: tabbarView)
        
        UIView.animate(withDuration: 0.3, animations: {
//            newController.view.alpha = 1
//            oldController.view.alpha = 0
        }) { (bo) in
        }
        
        old = to
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
//        if isFinished {
            isFinished = false
            transition(to: selectedIndex)
//        }
    }
}

