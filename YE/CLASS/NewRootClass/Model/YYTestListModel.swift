//
//  YYTestListModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import HandyJSON

class YYTestListModel: HandyJSON {
    var id: String = ""
    var name: String = ""
    var tag: Int = 0
    var vcName: String = ""
    var isNib: Bool = false
    
    required init() {
        
    }
}
