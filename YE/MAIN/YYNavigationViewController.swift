//
//  YYNavigationViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYNavigationViewController: UINavigationController {

    var isShowNavigationView: Bool = false
    
    var kNavigationViewBottomSpace: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    private func setupInteractivePopGestureRecognizer() {
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(pop(gestrure:)))
        // 全屏可滑动
        object_setClass(self.interactivePopGestureRecognizer, UIPanGestureRecognizer.self)
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

extension YYNavigationViewController: UIGestureRecognizerDelegate {
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
}

extension YYNavigationViewController: UINavigationControllerDelegate {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = true
        super.pushViewController(viewController, animated: true)
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
}

