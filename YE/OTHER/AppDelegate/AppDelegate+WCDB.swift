//
//  AppDelegate+WCDB.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/11.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension AppDelegate {
    
    func WCDBglobalTraceOfPerformance() {
//        Database.globalTrace { (tag, sqls, cost) in
//            if let wrappedTag = tag {
//                print("AppDelegate-WCDB Tag: \(wrappedTag)")
//            } else {
//                print("AppDelegate-WCDB Nil tag")
//            }
//            sqls.forEach({ (arg) in
//                print("AppDelegate-WCDB SQL: \(arg.key) Count: \(arg.value)")
//            })
//            print("AppDelegate-WCDBTotal cost \(cost) nanoseconds")
//        }
    }
    
    func WCDBglobalTraceOfSQL() {
//        Database.globalTrace(ofSQL: { (sql) in
//            print("AppDelegate-WCDB SQL: \(sql)")
//        })
    }
    
    func WCDBglobalTraceOfError() {
//        Database.globalTrace(ofError: { (error) in
//            switch error.type {
//            case .sqliteGlobal:
//                debugPrint("AppDelegate-[WCDB][DEBUG] \(error.description)")
//            case .warning:
//                print("AppDelegate-[WCDB][WARNING] \(error.description)")
//            case .sqlite:
//                if (error.code.value == 11 || error.code.value == 26) {
//                    print("WCDB 损坏检测 Tag: \(String(describing: error.tag)) is corrupted")
//                }
//            default:
//                print("AppDelegate-[WCDB][ERROR] \(error.description)")
//            }
//        })
    }
}
