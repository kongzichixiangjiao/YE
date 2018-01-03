//
//  YYPresentationBaseViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

/*
     var alertClickedHandler: YYPresentationBaseViewController.ClickedHandler = {
         tag in
         print(tag)
     }
 */

/*
     let d = YYPresentationDelegate(animationType: <#PresentationAnimationType#>)
     let vc = <#YYPresentationBaseViewController#>(nibName: "<#YYPresentationBaseViewController#>", bundle: nil, delegate: d)
     vc.clickedHandler = {
        tag in
        print(tag)
     }
     self.present(vc, animated: true, completion: nil)
 */

class YYPresentationBaseViewController: UIViewController {
    
    // 点击弹框按钮的闭包
    typealias ClickedHandler = (_ tag: Int, _ model: Any?) -> ()
    var clickedHandler: ClickedHandler?
    
    var isTapBack: Bool = true
    
    var duration: Double = 0
    var mTimer: Timer?
    
    var mDelegate: YYPresentationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if duration != 0 {
            mTimer = Timer.scheduledTimer(timeInterval: duration + 0.5, target: self, selector: #selector(selfDismiss(_:)), userInfo: nil, repeats: false)
        }
        
    }
    
    @objc func selfDismiss(_ timer: Timer) {
        dismiss()
    }
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, delegate: YYPresentationDelegate?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        guard let d = delegate else {
            let de = YYPresentationDelegate(animationType: .middle)
            self.transitioningDelegate = de
            self.mDelegate = de
            return
        }
        self.transitioningDelegate = d
        self.mDelegate = d
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if isTapBack {
            dismiss()
        }
    }
    
    public func dismiss() {
        guard let d = mDelegate else {
            let de = YYPresentationDelegate(animationType: .middle)
            self.transitioningDelegate = de
            self.dismiss(animated: true, completion: nil)
            return
        }
        
        let de = YYPresentationDelegate(animationType: d.presentationAnimationType)
        self.transitioningDelegate = de
        self.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        /*
         计时器暂停
         self.playerTimer.fireDate = Date.distantFuture
         计时器继续
         self.playerTimer.fireDate = Date.distantPast
         */
        self.mTimer?.invalidate()
    }
}

