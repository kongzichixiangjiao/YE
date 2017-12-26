//
//  YYRootViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYRootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let d = YYPresentationDelegate(animationType: .sheet)
        let vc = AnimationBaseViewController(nibName: "AnimationBaseViewController", bundle: nil, delegate: d)
        vc.clickedHandler = {
            tag in
            print(tag)
        }
        self.present(vc, animated: true, completion: nil)
    }
}

