//
//  NSArray+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension NSArray {
    
    var yy_toJSON: String! {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [JSONSerialization.WritingOptions.prettyPrinted])
            return String(data: data, encoding: String.Encoding.utf8)!
        } catch {
            
        }
        
        return ""
    }
    
}
