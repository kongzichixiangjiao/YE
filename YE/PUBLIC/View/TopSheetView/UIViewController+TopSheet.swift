//
//  UIViewController+TopSheet.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

// 提醒
enum YYTopSheetType: String {
    case message = "message", error = "error", finished = "finished"
}

extension UIViewController {
    
    func yy_showTopSheet(message: String, isNav: Bool = false, type: YYTopSheetType) {
        if let _ = self.view.viewWithTag(20180313) {
            return
        }
        
        let height: CGFloat = 64
        let v = UIView(frame: CGRect(x: 0, y: -height + (isNav ? 64 : 0) , width: self.view.frame.width, height: height))
        v.tag = 20180313
        self.view.addSubview(v)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHide(sender:)))
        v.addGestureRecognizer(tap)
        
        let tV = Bundle.main.loadNibNamed("YYTopSheetView", owner: self, options: nil)?.last as! YYTopSheetView
        tV.frame = v.bounds
        tV.type = type
        tV.text = message
        v.addSubview(tV)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 3, options: .curveEaseOut, animations: {
            v.frame = CGRect(x: 0, y: isNav ? 64 : 0, width: self.view.frame.width, height: height)
        }) { (finish) in
            if (finish) {
                
            }
        }
    }
    
    @objc func tapHide(sender: UITapGestureRecognizer) {
        yy_hideTopSheet()
    }
    
    func yy_hideTopSheet(isNav: Bool = false) {
        let height: CGFloat = 44
        var v = self.view.viewWithTag(20180313)
        
        UIView.animate(withDuration: 0.3, animations: {
            v?.frame = CGRect(x: 0, y: -height + (isNav ? -64 : 0) , width: self.view.frame.width, height: height)
            v?.alpha = 0.0
        }) { (finish) in
            if (finish) {
                v?.removeFromSuperview()
                v = nil
            }
        }
    }
    
}
