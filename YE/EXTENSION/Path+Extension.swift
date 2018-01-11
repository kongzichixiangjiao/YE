//
//  Path+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/9.
//  Copyright © 2018年 侯佳男. All rights reserved.
//  路径获取

import Foundation

extension String {
    enum PathEnum: String {
        case tmp, library, libraryCaches, libraryCookies, documents, systemData
    }
    static func path(type: PathEnum) -> String {
        switch type {
        case .tmp:
            return NSTemporaryDirectory() + "/"
        case .library:
            return NSHomeDirectory() + "/Library/"
        case .libraryCaches:
            return NSHomeDirectory() + "/Library/Caches/"
        case .libraryCookies:
            return NSHomeDirectory() + "/Library/Cookies/"
        case .documents:
            return NSHomeDirectory() + "Documents/"
        case .systemData:
            return NSHomeDirectory() + "SystemData/"
        }
    }
}
