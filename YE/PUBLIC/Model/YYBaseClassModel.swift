//
//  YYBaseClassModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON

class YYBaseClassModel: HandyJSON {
    var myMessage: String? = ""
    var returnCode: Int? = -1
    var myToken: String? = ""
    
    required init() {
        
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.myToken <-- "token"
        mapper <<<
            self.myMessage <-- "message"
    }
}
