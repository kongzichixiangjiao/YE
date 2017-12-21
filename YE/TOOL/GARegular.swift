//
//  GARegular.swift
//  OnlyWeather
//
//  Created by houjianan on 2017/3/10.
//  Copyright © 2017年 houjianan. All rights reserved.
//  正则判定 用户名 e_mail 手机号 链接 ip html

import Foundation

enum Regular: String {
    case userName = "^[a-z0-9_-]{3,16}$",
    eMail = "^([a-z0-9_.-]+)@([da-z.-]+).([a-z.]{2,6})$",
    phone = "^1[0-9]{10}$",
    url = "^(https?://)?([da-z.-]+).([a-z.]{2,6})([/w.-]*)*/?$",
    ip = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?).){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$",
    html = "^<([a-z]+)([^<]+)*(?:>(.*)</1>|s+/>)$",
    none = ""
    
}

class GARegular {
    static func match(_ input: String, _ regular: String = "", regularEnum: Regular = .none) -> Bool {
        
        let regular = regularEnum == .none ? regular : regularEnum.rawValue
        
        let regex = try? NSRegularExpression(pattern: regular, options: .caseInsensitive)
        if let matches = regex?.matches(in: input,
                                        options: [],
                                        range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
}


