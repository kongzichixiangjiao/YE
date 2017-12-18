//
//  YYNavigationViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYNavigationViewController: UINavigationController {

    var interactive: Bool = false
    // 控制转场 添加手势时会用到
    //    weak var interactiveTransition = UIPercentDrivenInteractiveTransition()
    let interactiveTransition: UIPercentDrivenInteractiveTransition? = nil
    
    var isShowNavigationView: Bool = false
    var kNavigationViewBottomSpace: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        self.delegate = self
    }
    
    private func setupInteractivePopGestureRecognizer() {
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(pop(gestrure:)))
        // 全屏可滑动
        object_setClass(self.interactivePopGestureRecognizer, UIPanGestureRecognizer.self)
        // 没有push的时候使用侧滑手势出错
        // self.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupInteractivePopGestureRecognizer()

        self.navigationBar.isHidden = true
    }

    @objc func pop(gestrure: UIPanGestureRecognizer) {
        if (gestrure.state == .ended) {
            let endPoint = gestrure.location(in: gestrure.view)
            if (endPoint.x > UIScreen.main.bounds.width / 2) {
                print("返回")
            } else {
                let velocity = gestrure.velocity(in: gestrure.view)
                print(velocity)
                print("没有返回")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension YYNavigationViewController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
        
        (self.tabBarController as! YYTabBarController).hideTabbarView()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        (self.tabBarController as! YYTabBarController).showTabbarView()
        return super.popViewController(animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
        return YYNavigationAnimationViewController(type: GATransitionType.navigationTransition(operation))
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil 
        return interactive ? self.interactiveTransition : nil
    }
}
