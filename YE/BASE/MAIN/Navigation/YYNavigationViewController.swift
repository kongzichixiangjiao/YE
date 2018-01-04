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
    
    weak var yy_tabBarController: YYMainRootViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.white
        
        self.navigationBar.isHidden = true
        
        self.delegate = self

        setupInteractivePopGestureRecognizer()
    }
    
    private func setupInteractivePopGestureRecognizer() {
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(pop(gestrure:)))
        // 全屏可滑动
        object_setClass(self.interactivePopGestureRecognizer, UIPanGestureRecognizer.self)
        // 没有push的时候使用侧滑手势出错
         self.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc func pop(gestrure: UIPanGestureRecognizer) {
        if (gestrure.state == .ended) {
            let endPoint = gestrure.location(in: gestrure.view)
            if (endPoint.x > UIScreen.main.bounds.width / 2) {
                print("返回")
            } else {
                let _ = gestrure.velocity(in: gestrure.view)
                print("没有返回")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let pop = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        let _ = pop.location(in: pop.view)
        let _ = pop.velocity(in: pop.view)
        return true
    }
}

extension YYNavigationViewController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
        yy_tabBarController?.hideTabbarView()
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
//        guard let _ = self.delegate else {
//            if self.viewControllers.count == 2 {
//                yy_tabBarController?.showTabbarView()
//            }
//            return super.popViewController(animated: animated)
//        }
        navigationController(self, didShow: self.viewControllers.first!, animated: true)
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        yy_tabBarController?.showTabbarView()
        return super.popToRootViewController(animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count == 1 {
            yy_tabBarController?.showTabbarView()
        }
    }
    
    /*
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return YYNavigationAnimationViewController(type: GATransitionType.navigationTransition(operation))
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? self.interactiveTransition : nil
    }
 */
}
