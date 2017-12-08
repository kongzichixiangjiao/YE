//
//  YYRequestManager.swift
//  YE
//
//  Created by 侯佳男 on 2017/9/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import UIKit
import Moya
import RxSwift
import Result
import RxCocoa


final class CustomPlugin: PluginType {
    // MARK: Plugin
}

public enum YYNetworkActivityChangeType {
    case began, ended
}

/// Notify a request's network activity changes (request begins or ends).
public final class YYNetworkActivityPlugin: PluginType {
    
    public typealias YYNetworkActivityClosure = (_ change: YYNetworkActivityChangeType, _ target: TargetType) -> Void
    let myNetworkActivityClosure: YYNetworkActivityClosure
    
    public init(newNetworkActivityClosure: @escaping YYNetworkActivityClosure) {
        self.myNetworkActivityClosure = newNetworkActivityClosure
    }
    
    // MARK: Plugin
    
    /// Called by the provider as soon as the request is about to start
    public func willSend(_ request: RequestType, target: TargetType) {
        myNetworkActivityClosure(.began,target)
    }
    
    /// Called by the provider as soon as a response arrives, even if the request is cancelled.
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        myNetworkActivityClosure(.ended,target)
    }
}

class YYRequest {
    
    static let share: YYRequest = YYRequest()
    
    var provider: MoyaProvider<YYApiManager>! {
        let publicParamEndpointClosure = { (target: YYApiManager) -> Endpoint<YYApiManager> in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            let endpoint = Endpoint<YYApiManager>(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            return endpoint.adding(newHTTPHeaderFields: ["x-platform" : "iOS", "x-interface-version" : "1.0"])
        }
        // MARK: - 自定义的网络提示请求插件
        let networkPlugin = YYNetworkActivityPlugin { (state,target) in
            if state == .began {
                print("开始加载")
                let api = target as! YYApiManager
                if api.show {
                    print("可以在这里写加载提示")
//                    UIApplication.shared.keyWindow?.rootViewController?.view.ga_showLoading()
                }
                
                if !api.touch {
                    print("可以在这里写禁止用户操作，等待请求结束")
                }
                print("我开始请求\(api.touch)")
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            } else {
                print("我结束请求")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
        
        let requestTimeoutClosure = { (endpoint: Endpoint<YYApiManager>, done: @escaping MoyaProvider<YYApiManager>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 30    //设置请求超时时间
                done(.success(request))
            } catch {
                
            }
        }
        return MoyaProvider<YYApiManager>(endpointClosure: publicParamEndpointClosure, requestClosure: requestTimeoutClosure, plugins: [networkPlugin])
    }
    
    
    func moya() {
        provider.request(.login(phoneNum: 12345678901, passWord: 123456, isShow: true, isTouch: true)) {
            result in
            switch result {
            case let .success(response):
                print(response)
                break
            case let .failure(error):
                print(error)
                break
            }
        }
    }
    // MARK: -取消所有请求
    func cancelAllRequest() {
        //    MyAPIProvider.manager.session.invalidateAndCancel()  //取消所有请求
        //        provider.manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
        //            dataTasks.forEach { $0.cancel() }
        //            uploadTasks.forEach { $0.cancel() }
        //            downloadTasks.forEach { $0.cancel() }
        //        }
        
        //        let sessionManager = Alamofire.SessionManager.default
        //        sessionManager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
        //            dataTasks.forEach { $0.cancel() }
        //            uploadTasks.forEach { $0.cancel() }
        //            downloadTasks.forEach { $0.cancel() }
        //        }
    }
}

