//
//  YYLog.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/6.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  Log打印

import Foundation

func log<T>(_ message:T, file: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print("")
        print("----LOGBEGAN--- \(fileName): \(line) \(function)--------")
        print("\(dateString) \(message)")
        print("----LOGEND-----")
    #endif
}
