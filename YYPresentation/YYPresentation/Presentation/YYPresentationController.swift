//
//  YYPresentationController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYPresentationController: UIPresentationController {

    var presentationAnimationType: PresentationAnimationType = .none
    var isShowMaskView: Bool = true
    // 遮罩层
    lazy var dimmingView: UIView = {
        let v = UIView()
        let dimmingViewInitailWidth = self.containerView!.frame.width, dimmingViewInitailHeight = self.containerView!.frame.height
        v.backgroundColor = UIColor(white: 0.0, alpha: 0.4)
        v.center = self.containerView!.center
        v.bounds = CGRect(x: 0, y: 0, width: dimmingViewInitailWidth , height: dimmingViewInitailHeight)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        v.addGestureRecognizer(tap)
        
        return v
    }()
    
    @objc private func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    convenience init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, type: PresentationAnimationType, isShowMaskView: Bool = true) {
        self.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.presentationAnimationType = type
        self.isShowMaskView = isShowMaskView
    }
    
    override func presentationTransitionWillBegin() {
        if isShowMaskView {
            containerView?.addSubview(dimmingView)
            self.dimmingView.bounds = self.containerView!.bounds
        }
        
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            _ in
            
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        _ = presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
    }
    
    override func containerViewWillLayoutSubviews(){
        dimmingView.center = containerView!.center
        dimmingView.bounds = containerView!.bounds
        
        // presentedView理解为弹出框的view containerView理解为整个屏幕
        guard let present = presentedView, let container = containerView else {
            return
        }
        
        let cW: CGFloat = container.bounds.width
        let cH: CGFloat = container.bounds.height
        let _: CGFloat = present.bounds.width
        let pH: CGFloat = UIScreen.main.bounds.height
        
        if presentationAnimationType == .sheet {
            present.frame = CGRect(x: 0, y: cH - pH, width: cW, height: pH)
        } else if presentationAnimationType == .alert {
            present.bounds = CGRect(x: 0, y: 0, width: cW, height: pH)
            present.center = containerView!.center
        }  else if presentationAnimationType == .alert {
            present.bounds = CGRect(x: 0, y: 0, width: cW, height: pH)
            present.center = containerView!.center
        } else {
            present.bounds = CGRect(x: 0, y: 0, width: cW, height: cH)
            present.center = containerView!.center
        }
    }
    
    override func containerViewDidLayoutSubviews() {}
    
    deinit {
        print("YYPresentationController deinit")
    }

}
