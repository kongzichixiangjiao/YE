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
    typealias ClickedHandler = (_ tag: Int) -> ()
    var clickedHandler: ClickedHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, delegate: YYPresentationDelegate?) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        guard let d = delegate else {
            let de = YYPresentationDelegate(animationType: .alert)
            self.transitioningDelegate = de
            return
        }
        self.transitioningDelegate = d
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

