//
//  AppDelegate+ListeningNetwork.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/6.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import Alamofire

extension AppDelegate
{
    //监听网络状态
    func  listenNetwork(){
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        
        manager?.listener = { status in
            
            switch status {
            case .unknown:
                break
            case.notReachable:
                break
            case .reachable:
                
                break
                
            }
            
            print("Network Status Changed: \(status)")
        }
        
        manager?.startListening()
        
        
    }
    
}
