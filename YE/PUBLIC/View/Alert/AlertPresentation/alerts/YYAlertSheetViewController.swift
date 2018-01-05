//
//  YYAlertSheetViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import YYPresentation

class YYAlertSheetViewController: YYPresentationBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func confirm(_ sender: UIButton) {
        clickedHandler!(99, "确认")
        dismiss()
    }
    
    @IBAction func cancle(_ sender: UIButton) {
        clickedHandler!(98, "取消")
        dismiss()
    }
    
    @IBAction func selected(_ sender: UIButton) {
        clickedHandler!(sender.tag, sender.titleLabel?.text)
        dismiss()
    }
    
}
