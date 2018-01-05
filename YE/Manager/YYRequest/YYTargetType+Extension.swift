//
//  TargetType+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import Moya

enum YYApiManager {
    case login(phoneNum: Double, passWord: Double, isShow: Bool, isTouch: Bool)
    case logout
    case getNewsList
    case jf_cjzh
}

extension YYApiManager: TargetType {
    var headers: [String : String]? {
        return ["":""]
    }
    
    var baseURL: URL {
        return URL(string: YYBaseUrl.url)!
    }
    
    var path: String {
        switch self {
        case .login(_, _, _, _):
            return "accountService/login"
        case .logout:
            return "accountService/logout"
        case .getNewsList:
            return "4/news/latest"
        case .jf_cjzh:
            return "/information/financeindex"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login(_, _, _, _):
            return .post
        case .logout:
            return .get
        case .getNewsList:
            return .get
        case .jf_cjzh:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .login(let phoneNum, let passWord, _, _):
            return ["phoneNum":phoneNum, "passWord":passWord]
        case .logout:
            return nil
        case .getNewsList:
            return nil
        case .jf_cjzh:
            return nil
        }
    }
    
    // Send parameters as JSON in request body
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var touch: Bool { //是否可以操作
        switch self {
        case .login(_, _, _, let isTouch):
            return isTouch
        default:
            return false
        }
    }
    
    var show: Bool { //是否显示转圈提示
        switch self {
        case .login(_, _, let isShow, _):
            return isShow
        default:
            return true
        }
        
    }
}
