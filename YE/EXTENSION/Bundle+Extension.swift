//
//  Bundle+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

extension Bundle {
    class func ga_path(_ path: String) -> String {
        let arr = path.components(separatedBy: ".")
        return Bundle.main.path(forResource: arr.first, ofType: arr.last, inDirectory: nil) ?? ""
    }
}
