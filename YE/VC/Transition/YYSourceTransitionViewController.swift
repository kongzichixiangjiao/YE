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
    
    @IBOutlet weak var moveView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func move(_ sender: UITapGestureRecognizer) {
        yy_routerAnimation = YYTransition(type: .move, isBack: false, fromeViewPath: "moveView", toViewPath: "toView")
        print(yy_routerAnimation)
        push(transition: yy_routerAnimation)
    }
    
    @IBAction func circle(_ sender: UITapGestureRecognizer) {
        yy_routerAnimation = YYTransition(type: .circle, fromeViewPath: "circleView")
        push(transition: yy_routerAnimation)
    }
    
    @IBAction func middle(_ sender: UIButton) {
        yy_routerAnimation = YYTransition(type: .middle, fromeViewPath: "circleView")
        push(transition: yy_routerAnimation)
    }
    
    @IBAction func tier(_ sender: UIButton) {
        yy_routerAnimation = YYTransition(type: .tier)
        push(transition: yy_routerAnimation)
    }
    
    private func push(transition: YYTransition) {
        let vc = YYTargetTransitionViewController(nibName: "YYTargetTransitionViewController", bundle: nil)
        self.navigationController?.delegate = transition
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
