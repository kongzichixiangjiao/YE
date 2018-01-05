//
//  YYRequestModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Moya
import Result
import HandyJSON

class YYRequestModel {
    var json: Any? = nil
    var jsonValue: Response? = nil
    var jsonString: String? = ""
    var message: String? = ""
    var returnCode: Int? = -1
    var token: String? = ""
    var resultDic: [String:Any]? = nil
    
    var statusCode: Int = 8080
    
    var requestUrl: String = ""
    var baseUrl: String = ""
    var apiManager: YYApiManager? = nil
    var apiPath: String! = ""
    
    var error: Error? = nil
    var errorString: String = ""
    var errorCode: Int = 8080
    
    convenience init(api: YYApiManager, result: Result<Moya.Response, MoyaError>) {
        self.init()
        self.jsonValue = result.value
        do {
            self.json = try result.value?.filter(statusCode: 200).mapJSON()
        } catch let error {
            print("result.value?.filter(statusCode: 200).mapJSON() 异常: ", error)
        }
        do {
            self.jsonString = try result.value?.mapString()
        } catch let error {
            print("result.value?.mapString() 异常: ", error)
        }
        
        self.resultDic = self.json as? [String : Any]
        
        self.statusCode = result.value?.statusCode ?? 8080
        self.requestUrl = result.value?.response?.url?.absoluteString ?? ""
        self.apiManager = api
        self.baseUrl = api.baseURL.absoluteString
        self.apiPath = api.path
        self.error = result.error
        self.errorString = result.error?.errorDescription ?? "本地打印：无错误信息"
        self.errorCode = result.value?.statusCode ?? 8080
    }
}

class YYResultModel: HandyJSON {
    required init() {
        
    }
    
    var returnCode: Int = -1
    var token: String = ""
    var message: String = ""
    var result: Any? = nil {
        didSet {
            if let dictionary = result as? [String: Any] {
                self.resultDic = dictionary
            } else if let array = result as? [Any] {
                self.resultArray = array
            } else if let value = result as? NSNumber {
                if value.isBool {
                    self.resultBool = value as? Bool
                } else {
                    self.resultInt = value as? Int
                }
            } else if let bool = result as? Bool {
                self.resultBool = bool
            } else {
                
            }
        }
    }
    var resultDic: [String : Any]? = ["":""]
    var resultArray: [Any]? = []
    var resultString: String? = ""
    var resultBool: Bool? = false
    var resultInt: Int? = -1
    
    init(json: Any?) {
        if let dictionary = json as? [String: Any] {
            self.returnCode = dictionary["returnCode"] as? Int ?? -1
            self.token = dictionary["token"] as? String ?? ""
            self.message = dictionary["message"] as? String ?? ""
        }
    }
    
    func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        if #available(iOS 8.3, *) {
            escaped = string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
        } else {
            let batchSize = 50
            var index = string.startIndex
            
            while index != string.endIndex {
                let startIndex = index
                let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
                let range = startIndex..<endIndex
                
                let substring = string[range]
                
                escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
                
                index = endIndex
            }
        }
        
        return escaped
    }
}

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

