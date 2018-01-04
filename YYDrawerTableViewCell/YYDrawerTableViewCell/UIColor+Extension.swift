//
//  UIColor+Extension.swift
//  YYDrawerTableViewCell
//
//  Created by 侯佳男 on 2018/1/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

extension UIColor {
    static func cell_randomColor(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: alpha)
    }
}
