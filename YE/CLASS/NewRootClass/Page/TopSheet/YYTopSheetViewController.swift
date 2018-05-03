//
//  YYTopSheetViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYTopSheetViewController: YYXIBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTitle = "TopSheet"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.yy_showTopSheet(message: "测试信息", type: .error)
//    }

    @IBAction func clickedAction(_ sender: UIButton) {
        self.yy_showTopSheet(message: "你的操作出现了严重的错误！你是不是傻掉了？！！", type: .error)
    }
}
