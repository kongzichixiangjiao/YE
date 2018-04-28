//
//  YYTopSheetViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYTopSheetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.yy_showTopSheet(message: "测试信息", type: .error)
    }

}
