//
//  URL+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

extension URL {
    var ga_request: URLRequest? {
        get {
            return URLRequest(url: self)
        }
    }
}
