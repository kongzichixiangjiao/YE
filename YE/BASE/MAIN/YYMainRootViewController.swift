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
        let newController = vcs[to]
        let oldController = self.childViewControllers.last!
        
        oldController.willMove(toParentViewController: nil)
        addChildViewController(newController)
        newController.view.frame = oldController.view.frame
        
        transition(from: oldController, to: newController, duration: 0.2, options: UIViewAnimationOptions.transitionCrossDissolve, animations: nil, completion: { (finished) -> Void in
            oldController.removeFromParentViewController()
            newController.didMove(toParentViewController: self)
        })
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
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
            self.tabbarView.frame = CGRect(x: 0, y: self.view.height - 49, width: self.view.width, height: 49)
        }) { (bo) in
            self.tabbarView.centerButton.isHidden = true
        }
        
        
    }
    
    public func hideTabbarView(animation: Bool = true) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .allowAnimatedContent, animations: {
            self.tabbarView.frame = CGRect(x: 0, y: self.view.height, width: self.view.width, height: 49)
        }) { (bo) in
            self.tabbarView.centerButton.isHidden = true
        }
        
    }
    
}

extension YYMainRootViewController: YYBaseTabBarViewDelegate {
    func clickedTabbar(selectedIndex: Int) {
        transition(to: selectedIndex)
    }
}

