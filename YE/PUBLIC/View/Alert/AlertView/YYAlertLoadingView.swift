//
//  YYAlertView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/6.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

// MARK: loading
protocol LoadingProtocol {
    var toastView: UIView { set get }
    var activity: UIActivityIndicatorView { set get }
    var loadingTextLabel: UILabel { set get }
}

extension UIView: LoadingProtocol {
    
    var loadingTextLabel: UILabel {
        get {
            guard let loadingTextLabel: UILabel = objc_getAssociatedObject(self, &YYAlertKey.kLoadingTextLabel) as? UILabel else {
                let v = UILabel()
                v.font = UIFont.systemFont(ofSize: 13)
                v.textColor = UIColor.white
                v.textAlignment = .center 
                
                objc_setAssociatedObject(self, &YYAlertKey.kLoadingTextLabel, v, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return v
            }
            return loadingTextLabel
        }
        set {
            
        }
    }
    
    var activity: UIActivityIndicatorView {
        get {
            guard let activity: UIActivityIndicatorView = objc_getAssociatedObject(self, &YYAlertKey.kActivity) as? UIActivityIndicatorView else {
                let activity = UIActivityIndicatorView(activityIndicatorStyle: .white)
                activity.startAnimating()
                
                objc_setAssociatedObject(self, &YYAlertKey.kActivity, activity, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return activity
            }
            return activity
        }
        set {
            
        }
    }
    
    var loadingIconImageView: UIImageView {
        get {
            guard let loadingIconImageView: UIImageView = objc_getAssociatedObject(self, &YYAlertKey.kLoadingIconImageView) as? UIImageView else {
                let v = UIImageView()

                objc_setAssociatedObject(self, &YYAlertKey.kLoadingIconImageView, v, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return v
            }
            return loadingIconImageView
        }
        set {
            
        }
    }
    
    var toastView: UIView {
        get {
            guard let toastView: UIView = objc_getAssociatedObject(self, &YYAlertKey.kToastView) as? UIView else {
                let toastView = UIView()
                toastView.backgroundColor = UIColor.darkGray
                toastView.alpha = 0.85
                toastView.layer.cornerRadius = 10
                
                objc_setAssociatedObject(self, &YYAlertKey.kToastView, toastView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return toastView
            }
            return toastView
        }
        set {
            
        }
    }
    
    func showLoadingView() {
        activity.center = alertWindow.center
        toastView.frame = CGRect(origin: alertWindow.center, size: CGSize(width: 100, height: 100))
        toastView.center = alertWindow.center
        showAnimation(toastView)
        showAnimation(activity)
    }
    
    func showTextLoadingView(_ type: YYAlertViewTextType, text: String) {
        showLoadingTextLabel(type, text: text)
    }
    
    func showLoadingTextLabel(_ type: YYAlertViewTextType, text: String) {
        showAnimation(toastView)
        let space: CGFloat = 10
        switch type {
        case .error, .success:
            showAnimation(loadingIconImageView)
            let image = UIImage(named: type.rawValue)
            let w: CGFloat = 30
            loadingIconImageView.frame = CGRect(x: toastView.center.x - w / 2, y: toastView.frame.origin.y + space * 2, width: w, height: w)
            loadingIconImageView.image = image
            break
        case .loading:
            showAnimation(activity)
            activity.frame = CGRect(x: activity.frame.origin.x, y: activity.frame.origin.y - space, width: activity.frame.size.width, height: activity.frame.size.height)
            break
        }
        
        let lH: CGFloat = 13
        loadingTextLabel.frame = CGRect(x: self.toastView.frame.origin.x, y: self.toastView.frame.origin.y + self.toastView.frame.size.height - space * 2 - lH, width: self.toastView.frame.size.width, height: lH)
        loadingTextLabel.text = text
        showAnimation(loadingTextLabel)
    }
    
    func hideLoadingView() {
        hideAnimation(toastView)
        hideAnimation(activity)
    }
    
    func hideTextLoadingView() {
        hideAnimation(toastView)
        hideAnimation(loadingTextLabel)
        hideAnimation(loadingIconImageView)
    }
}


