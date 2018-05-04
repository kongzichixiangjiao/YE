//
//  PXCustomsFormModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON

class PXCustomsFormModel: HandyJSON {
    var isSelected: Bool = false
    var isShowLine: Bool = false
    var title = ""
    var subtitle = ""
    
    var items: [PXCustomsFormItemsModel] = []
    
    required init() {
        
    }
}

class PXCustomsFormItemsModel: HandyJSON {
    
    var name = ""
    var text = ""
    var placeText = ""
    var isMust = false
    var isEdit = false
    var isClicked = false 
    var isLast = false
    var type = -1
    
    required init() {
        
    }
}
