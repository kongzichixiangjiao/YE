//
//  Compare+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  比较 判断是否 相等

import Foundation

class Compare {
    
    static func ga_MAX<T: Comparable>(_ a: T, _ b: T) -> T {
        if a > b {
            return a
        } else {
            return b
        }
    }
    
    static func ga_isEquals<T: Comparable>(_ a: T, b: T) -> Bool {
        return (a == b)
    }
}
