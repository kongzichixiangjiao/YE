//
//  YYTransition+Circle.swift
//  YYTransition
//
//  Created by 侯佳男 on 2017/12/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYTransition {
    
    func circleAnimateTransition(isBack: Bool, using transitionContext: UIViewControllerContextTransitioning) {
        self.yy_transitionContext = transitionContext
        if isBack {
            circleExecuteAnimationBack(using: transitionContext)
        } else {
            circleExecuteAnimation(using: transitionContext)
        }
    }
    
    func circleExecuteAnimation(using context: UIViewControllerContextTransitioning) {
        // The view in which the animated transition should take place.
        let containerView = context.containerView
        // 获取目标vc和源view snapview
        guard let toVC = context.viewController(forKey: .to) else {
            return
        }
        guard let fromVC = context.viewController(forKey: .from) else {
            return
        }
        guard let fPath = self.yy_fromViewPath else {
            return
        }
        let fromView = fromVC.value(forKeyPath: fPath) as! UIView
        guard let snapView = fromView.snapshotView(afterScreenUpdates: false) else {
            return
        }
        snapView.frame = relativeFrame(for: fromView)
        
//        toVC.yy_fromView = snapView
        
        containerView.addSubview(snapView)
        containerView.addSubview(toVC.view)
        
        let finalPoint = calculateFinalPoint(toVC: toVC, fromView: fromView)
        let x = finalPoint.x, y = finalPoint.y, r = sqrt(x*x+y*y)
        let startPath = UIBezierPath(ovalIn: snapView.frame)
        let endPath = UIBezierPath(ovalIn: snapView.frame.insetBy(dx: -r, dy: -r))
        
        maskAnimation(targetVC: toVC, startPath: startPath, endPath: endPath, context: context)
    }
    
    func circleExecuteAnimationBack(using context: UIViewControllerContextTransitioning) {
        guard let toVC = context.viewController(forKey: .to) else { return }
        guard let fromVC = context.viewController(forKey: .from) else { return }
        let containerView = context.containerView
//        let toView = fromVC.yy_fromView
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(fromVC.view)
//        let finalPoint = calculateFinalPoint(toVC: toVC, fromView: toView)
//        let x = finalPoint.x, y = finalPoint.y, r = sqrt(x*x+y*y)
//        let startPath = UIBezierPath(ovalIn: toView.frame.insetBy(dx: -r, dy: -r))
//        let endPath = UIBezierPath(ovalIn: toView.frame)
        
//        maskAnimation(targetVC: fromVC, startPath: startPath, endPath: endPath, context: context)
    }
    
    func relativeFrame(for target: UIView) -> CGRect {
        let screenHeight = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        
        var view = target
        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        
        while view.frame.width != screenWidth || view.frame.height != screenHeight {
            x += view.frame.minX
            y += view.frame.minY
            guard let superView = view.superview else { break }
            view = superView
            if view.isKind(of: UIScrollView.self) {
                let scrollView = view as! UIScrollView
                x -= scrollView.contentOffset.x
                y -= scrollView.contentOffset.y
            }
        }
        
        return CGRect(x: x, y: y, width: target.frame.width, height: target.frame.height)
    }
    
    func calculateFinalPoint(toVC: UIViewController, fromView: UIView) -> CGPoint {
        var finalPoint = CGPoint.zero
        
        if fromView.frame.minX > (toVC.view.bounds.width / 2) {
            if fromView.frame.minY < (toVC.view.bounds.height / 2) {
                finalPoint = CGPoint(x: fromView.center.x - 0, y: fromView.center.y - toVC.view.frame.maxY)
            } else {
                finalPoint = CGPoint(x: fromView.center.x - 0, y: fromView.center.y - fromView.center.y - 0)
            }
        } else {
            if fromView.frame.minY < (toVC.view.bounds.height / 2) {
                finalPoint = CGPoint(x: fromView.center.x - toVC.view.bounds.maxX, y: fromView.center.y - toVC.view.bounds.maxY)
            } else {
                finalPoint = CGPoint(x: fromView.center.x - toVC.view.bounds.maxX, y: fromView.center.y - 0)
            }
        }
        return finalPoint
    }
    
}

