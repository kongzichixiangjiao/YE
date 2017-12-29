//
//  YYSourceTransitionViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/29.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import YYTransition

class YYSourceTransitionViewController: UIViewController {

    @IBOutlet weak var circleView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        yyPush.setDelegate()
    }
    
    @IBAction func move(_ sender: UITapGestureRecognizer) {
        let type = YYTransitionAnimationType.move(isBack: false)
        yyPush.transition(type: type, fromView: sender.view, toViewPath: "toView")
        
        let vc = YYTargetTransitionViewController(nibName: "YYTargetTransitionViewController", bundle: nil)
        vc.type = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func circle(_ sender: UITapGestureRecognizer) {
        
        let type = YYTransitionAnimationType.circle(isBack: false)
        yyPush.transition(type: type, fromView: circleView)
        
        let vc = YYTargetTransitionViewController(nibName: "YYTargetTransitionViewController", bundle: nil)
        vc.type = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func middle(_ sender: UIButton) {
        let type = YYTransitionAnimationType.middle(isBack: false)
        yyPush.transition(type: type)
        
        let vc = YYTargetTransitionViewController(nibName: "YYTargetTransitionViewController", bundle: nil)
        vc.type = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func tier(_ sender: UIButton) {
        let type = YYTransitionAnimationType.tier(isBack: false)
        yyPush.transition(type: type)
        
        let vc = YYTargetTransitionViewController(nibName: "YYTargetTransitionViewController", bundle: nil)
        vc.type = type
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
