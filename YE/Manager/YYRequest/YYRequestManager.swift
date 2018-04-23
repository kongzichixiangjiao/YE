//
//  YYRequestManager.swift
//  YE
//
//  Created by 侯佳男 on 2017/9/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import Result


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
    
    var cancellables: [Cancellable] = []
    
    lazy var provider: MoyaProvider<YYApiManager>! = {
        let publicParamEndpointClosure = { (target: YYApiManager) -> Endpoint in
            let url = target.baseURL.appendingPathComponent(target.path).absoluteString
            let endpoint = Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
            return endpoint.adding(newHTTPHeaderFields: ["x-platform" : "iOS", "x-interface-version" : "1.0"])
        }
        // MARK: - 自定义的网络提示请求插件
        let networkPlugin = YYNetworkActivityPlugin { (state,target) in
            if state == .began {
                print("开始加载")
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                let api = target as! YYApiManager
                if api.show {
                    print("可以在这里写加载提示")
                    YYToast.ga.show()
                }
                
                if !api.touch {
                    print("可以在这里写禁止用户操作，等待请求结束")
                }
                print("开始请求\(api.touch)")
            } else {
                print("结束请求")
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                    DispatchQueue.main.async {
                        YYToast.ga.hide()
                    }
                })
            }
        }
        
        let requestTimeoutClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<YYApiManager>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 12    //设置请求超时时间
                done(.success(request))
            } catch {
                
            }
        }
        return MoyaProvider<YYApiManager>(endpointClosure: publicParamEndpointClosure, requestClosure: requestTimeoutClosure, plugins: [networkPlugin])
    }()
    
    typealias CompletedErrorHandler = (_ errorCode: Int, _ errorDescription: String) -> ()
    typealias CompletedSuccessHandler = (_ result: YYRequestModel) -> ()
    typealias ProgressHandler = (_ progress: Double, _ completed: Bool) -> ()
    
    func request(target: YYApiManager, callbackQueue: DispatchQueue? = nil, progress: ProgressHandler? = nil, success: @escaping CompletedSuccessHandler, failed: @escaping CompletedErrorHandler) {
       let cancellable = provider.request(target, callbackQueue: callbackQueue, progress: { (response) in
        print("progress: ", response.progress)
        print("completed: ", response.completed)
        print("Progress类型: ", response.progressObject ?? "--")
        progress?(response.progress, response.completed)
        }) { (result) in
            let resultModel = YYRequestModel(api: target, result: result)
            switch result {
            case .success:
                guard let _ = resultModel.json else {
                    self.completionBackError(resultModel: resultModel, completion: failed)
                    return
                }
                self.completionBackSuccess(resultModel: resultModel, completion: success)
                break
            case .failure:
                self.completionBackError(resultModel: resultModel, completion: failed)
                break 
            }
        }
        cancellables.append(cancellable)
    }
    
    private func completionBackSuccess(resultModel: YYRequestModel, completion: CompletedSuccessHandler) {
        completion(resultModel)
    }
    
    private func completionBackError(resultModel: YYRequestModel, completion: CompletedErrorHandler) {
        completion(resultModel.errorCode, resultModel.errorString)
    }
    
    // MARK: 取消所有请求
    func cancelAllRequest() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
}


