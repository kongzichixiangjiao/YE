//
//  YYTargetTransitionViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/29.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import YYTransition

class YYTargetTransitionViewController: UIViewController {

    @IBOutlet weak var toView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
//        yy_routerAnimation = YYTransition(type: .tier)
        yy_routerAnimation = YYTransition(type: .move, isBack: true, fromeViewPath: "toView", toViewPath: "toView")
        yy_routerAnimation.yy_isBack = true
        self.navigationController?.delegate = yy_routerAnimation
        self.navigationController?.popViewController(animated: true)
    }

}
