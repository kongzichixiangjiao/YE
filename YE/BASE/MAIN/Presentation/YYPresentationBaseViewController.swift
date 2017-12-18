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
     let d = YYPresentationDelegate(animationType: .alert)
     let vc = YYPresentationBaseViewController()
     vc.transitioningDelegate = d
     vc.modalPresentationStyle = .custom
     vc.clickedHandler = {
         tag in
         print(tag)
    }
    self.present(vc, animated: true, completion: nil)
 */

class YYPresentationBaseViewController: UIViewController {
    
    // 点击弹框按钮的闭包
    typealias ClickedHandler = (_ tag: Int) -> ()
    var clickedHandler: ClickedHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, a: Int) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        let d = YYPresentationDelegate(animationType: .alert)
        transitioningDelegate = d
        modalPresentationStyle = .custom
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
    
}

