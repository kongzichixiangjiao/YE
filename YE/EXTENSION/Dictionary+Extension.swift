//
//  Dictionary+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/9/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

extension Dictionary {
    static func +=(lhs: inout Dictionary, rhs: Dictionary?) -> Void {
        
        guard let rhs = rhs else {
            return
        }
        
        for (key, value) in rhs {
            lhs[key] = value
        }
    }
    
    static func +(lhs: Dictionary, rhs: Dictionary?) -> Dictionary {
        var lhs = lhs
        lhs += rhs
        return lhs
    }
}
