//
//  YYRequestManager.swift
//  YE
//
//  Created by 侯佳男 on 2017/9/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import Alamofire

open class YYRequest {
    
    var query: [String: Any]?
    
    static var query: Int?
    
    func query(_ a: Int?) {
        
    }
    
    fileprivate(set) var name: String?
    fileprivate(set) var name3: String?
    
    open fileprivate(set) var name1: String? // 只读
    
    // public private(get) var name2: String? //
    
    final func cancle() {
        Alamofire.request("").cancel()
    }
    fileprivate func a() {
        
    }
    fileprivate func b() {
        
    }
    internal func cc() {
        
    }
    open func zz() {
    
    }
}


class YYRequestSon: YYRequest {
    func c() {
        cancle()
        cc()
        
    }
    
}

class AA {
    func a() {
        
    }
}


//import Alamofire
//
//
//typealias ResposeComplete = ()
//
//class HTTPRequest {
//    
//    private var _query: [String: Any]?
//    var query: [String: Any]? {
//        return _query
//    }
//    
//    init(_ query: [String: Any]? = nil) {
//        var dic = [String: Any]()
//        let device = UIDevice.current
//        dic["appVersion"] = AppVersion
//        dic["appBuildNumber"] = AppBuildNumber
//        dic["systemVersion"] = device.systemVersion
//        dic["systemName"] = device.systemName
//        dic["deviceModel"] = device.model
//        dic["deviceName"] = device.name
//        dic["deviceId"] = String.deviceID()
//        dic["platform"] = 1
//        
//        if let userId = UserInfo.user?.staffId {
//            dic["staffId"] = userId
//        }
//        
//        _query = dic + query
//        
//    }
//    
//    var host: String {
//        return ""
//    }
//    
//    var path: String {
//        return ""
//    }
//    
//    var methord: HTTPMethod {
//        return .post
//    }
//    
//    var encoding: URLEncoding {
//        return .default
//    }
//    
//    var headers: HTTPHeaders? {
//        return nil
//    }
//}
//
//extension HTTPRequest {
//    func request() -> DataRequest {
//        let request = Alamofire.request(host+path, method: methord, parameters: query, encoding: encoding, headers: headers)
//        return request
//    }
//}
//
//class HTTPDownloadRequest: HTTPRequest {
//    
//    var downloadProgress: ((_ progress: Progress) -> Void)?
//    
//    func downloadFileDestination (_ temporaryURL: URL, _ response: HTTPURLResponse) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) {
//        let path = String.path(forPath: String.documentPath, fileName: response.suggestedFilename!, inDirName: "download")
//        return (NSURL.fileURL(withPath: path), .removePreviousFile)
//    }
//    
//    func download() -> DownloadRequest {
//        let request = Alamofire.download(host+path, method: methord, parameters: query, encoding: encoding, headers: headers, to: downloadFileDestination)
//        return request
//    }
//}
//
//class HTTPUploadRequest: HTTPRequest {
//    
//    func upload(multipartFormData data:(@escaping (MultipartFormData) -> Void), completion:((UploadRequest) -> Void)? = nil) -> Void {
//        
//        Alamofire.upload(multipartFormData: { (formData) in
//            if let query = self.query {
//                for (key, value) in query {
//                    formData.append("\(value)".data(using: .utf8)!, withName: key)
//                }
//            }
//            
//            data(formData)
//            
//        }, to: host+path, method: methord, headers: headers) { (rs) in
//            switch rs {
//            case .success(let request, _, _):
//                if let completion = completion {
//                    completion(request)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    
//    func upload(images:[UIImage], completion:((UploadRequest) -> Void)? = nil) -> Void {
//        
//        Alamofire.upload(multipartFormData: { (formData) in
//            
//            if let query = self.query {
//                for (key, value) in query {
//                    formData.append("\(value)".data(using: .utf8)!, withName: key)
//                }
//            }
//            
//            for image in images {
//                formData.append(UIImageJPEGRepresentation(image, 1)!, withName: "", fileName: "", mimeType: "")
//            }
//            
//            
//        }, to: host+path, method: methord, headers: headers) { (rs) in
//            switch rs {
//            case .success(let request, _, _):
//                if let completion = completion {
//                    completion(request)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
