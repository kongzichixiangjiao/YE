//
//  YYBaseUrl.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

class YYBaseUrl {
    
    enum ServiceBaseType: String {
        case base = "http://news-at.zhihu.com/api/"
        case jf = "https://jfapp.puxinasset.com/jfapp"
    }
    
    static let url: String = ServiceBaseType.jf.rawValue
    
}

