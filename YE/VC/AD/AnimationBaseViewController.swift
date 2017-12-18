//
//  AnimationBaseViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

/*
 var alertClickedHandler: AnimationBaseViewController.ClickedHandler = {
    tag in
    print(tag)
 }
 */

/*
 let d = YYPresentationDelegate(animationType: .alert)
 let vc = AnimationBaseViewController()
 vc.transitioningDelegate = d
 vc.modalPresentationStyle = .custom
 vc.clickedHandler = {
    tag in
    print(tag)
 }
 self.present(vc, animated: true, completion: nil)
 */
class AnimationBaseViewController: YYPresentationBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
            self.dismiss(animated: true, completion: nil)
        clickedHandler?(2)
    }
    
}
