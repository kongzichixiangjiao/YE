//
//  UIStoryboard+Extension.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

private let kStoryboadName = "Main"
extension UIStoryboard {
    static func yy_main() -> UIStoryboard {
        return UIStoryboard(name: kStoryboadName, bundle: nil)
    }
    
    static func yy_main(vcName: String) -> UIViewController? {
        print("Storyboard ID 设置了吗？")
        let vc = UIStoryboard(name: kStoryboadName, bundle: nil).instantiateViewController(withIdentifier: vcName)
        return vc
    }
    
    
    static func yy_storyboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
    static func yy_storyboard(name: String, vcName: String) -> UIViewController? {
        print("Storyboard ID 设置了吗？")
        let vc = UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: vcName)
        return vc
    }
}
