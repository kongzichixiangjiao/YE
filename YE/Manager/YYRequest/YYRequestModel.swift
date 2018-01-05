//
//  YYRequestModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Moya
import Result

class YYRequestModel {
    var json: Any? = nil
    var statusCode: Int = 8080
    var jsonString: String? = ""
    var requestUrl: String = ""
    var baseUrl: String = ""
    var apiManager: YYApiManager? = nil
    var apiPath: String! = ""
    var error: Error? = nil
    var errorString: String = ""
    var errorCode: Int = 8080
    
    convenience init(api: YYApiManager, result: Result<Moya.Response, MoyaError>) {
        self.init()
        do {
            self.json = try result.value?.filter(statusCode: 200).mapJSON()
        } catch let error {
            print("result.value?.filter(statusCode: 200).mapJSON() 异常: ", error)
        }
        self.statusCode = result.value?.statusCode ?? 8080
        do {
            self.jsonString = try result.value?.mapString()
        } catch let error {
            print("result.value?.mapString() 异常: ", error)
        }
        self.requestUrl = result.value?.response?.url?.absoluteString ?? ""
        self.apiManager = api
        self.baseUrl = api.baseURL.absoluteString
        self.apiPath = api.path
        self.error = result.error
        self.errorString = result.error?.errorDescription ?? "本地打印：无错误信息"
        self.errorCode = result.value?.statusCode ?? 8080
    }
}
