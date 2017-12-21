//
//  YYSystemPassword.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/21.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  验证系统指纹和密码
/*
 第一个枚举LAPolicyDeviceOwnerAuthenticationWithBiometrics就是说，用的是手指指纹去验证的；NS_ENUM_AVAILABLE(NA, 8_0)iOS8 可用
 第二个枚举LAPolicyDeviceOwnerAuthentication少了WithBiometrics则是使用TouchID或者密码验证,默认是错误两次指纹或者锁定后,弹出输入密码界面;NS_ENUM_AVAILABLE(10_11, 9_0)iOS 9可用
 
 1、iOS 9 之前是没有LAErrorTouchIDLockout锁定这个选项的,默认错误5次后;第6次验证是自动弹出输入密码界面;
 2、iOS 9 之后锁定指纹识别之后,如果需要立即弹出输入密码界面需要使用LAPolicyDeviceOwnerAuthentication这个属性重新发起验证
 3、如果输入了锁屏密码,指纹解密锁定会默认解除
 */
/*
 YYSystemPassword.share.systemPasswordEvaluate { (result) in
     if (result) {
        self.navigationController?.popViewController(animated: true)
     } else {
        print("失败")
     }
 }
 */

import Foundation
import LocalAuthentication

class YYSystemPassword {
    
    static let share: YYSystemPassword = YYSystemPassword()
    
    typealias SystemPasswordHandler = (_ success: Bool) -> ()
    private var systemPasswordHandler: SystemPasswordHandler!
    
    public func systemPasswordEvaluate(handler: @escaping SystemPasswordHandler) {
        self.systemPasswordHandler = handler
        
        evaluateDeviceOwnerAuthenticationWithBiometrics()
    }
    
    private func evaluateDeviceOwnerAuthenticationWithBiometrics() {
        let myContext = LAContext()
        let myLocalizedReasonString = "进行手势识别"
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        // User authenticated successfully, take appropriate action
                        print("success")
                        DispatchQueue.main.async {
                            self.systemPasswordHandler(true)
                        }
                    } else {
                        // User did not authenticate successfully, look at error and take appropriate action
                        self.evaluateDeviceOwnerAuthentication()
                    }
                }
            } else {
                print("failed1")
                evaluateDeviceOwnerAuthentication()
            }
        }
    }
    
    private func evaluateDeviceOwnerAuthentication() {
        let myContext = LAContext()
        let myLocalizedReasonString = "密码输入"
        var authError: NSError?
        if myContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError) {
            myContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: myLocalizedReasonString) { success, evaluateError in
                if success {
                    // User authenticated successfully, take appropriate action
                    print("success")
                    DispatchQueue.main.async {
                        self.systemPasswordHandler(true)
                    }
                } else {
                    // User did not authenticate successfully, look at error and take appropriate action
                    print("failed2")
                    self.systemPasswordHandler(false)
                }
            }
        } else {
            self.systemPasswordHandler(false)
        }
    }
    
}
