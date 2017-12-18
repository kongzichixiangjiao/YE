//
//  YYBaseImagePickerController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYBaseImagePickerController: UIImagePickerController {

    var model: YYBaseImagePickerControllerModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

struct YYBaseImagePickerControllerModel {
    var row: Int!
    var tag: Int!
}
