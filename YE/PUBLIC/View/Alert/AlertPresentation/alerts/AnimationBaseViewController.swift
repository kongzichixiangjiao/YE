//
//  AnimationBaseViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  各种alert弹框 自定义

import UIKit
import YYPresentation
/*
 var alertClickedHandler: AnimationBaseViewController.ClickedHandler = {
    tag in
    print(tag)
 }
 */

/*
 let d = YYPresentationDelegate(animationType: .sheet)
 let vc = AnimationBaseViewController(nibName: "AnimationBaseViewController", bundle: nil, delegate: d)
 vc.clickedHandler = {
    tag in
    print(tag)
 }
 self.present(vc, animated: true, completion: nil)
 */
class AnimationBaseViewController: YYPresentationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isTapBack = false 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
        clickedHandler?(2, "")
    }
    
}
