//
//  YYAlertAlertViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import YYPresentation

class YYAlertAlertViewController: YYPresentationBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cinfirm(_ sender: UIButton) {
        clickedHandler!(119, "确认")
        dismiss()
    }
    
    @IBAction func cancle(_ sender: UIButton) {
        clickedHandler!(110, "取消")
        dismiss()
    }
    
}
