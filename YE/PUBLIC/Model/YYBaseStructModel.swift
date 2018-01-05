//
//  YYBaseStructModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON

struct YYBaseStructModel: HandyJSON {
    var myMessage: String? = ""
    var returnCode: Int? = -1
    var myToken: String? = ""
    var result: YYPXModel!
    
    var parent: (String, String)?
    
    
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.myToken <-- "token"
        mapper <<<
            self.myMessage <-- "message"
        
        /*
        // specify 'parent' field in json parse as following to 'parent' property in object
        mapper <<<
            self.parent <-- TransformOf<(String, String), String>(fromJSON: { (rawString) -> (String, String)? in
                if let parentNames = rawString?.characters.split(separator: "/").map(String.init) {
                    return (parentNames[0], parentNames[1])
                }
                return nil
            }, toJSON: { (tuple) -> String? in
                if let _tuple = tuple {
                    return "\(_tuple.0)/\(_tuple.1)"
                }
                return nil
            })
        */
    }
}

