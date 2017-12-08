//
//  CGFloat+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

protocol CGFloatProtocol {
    var scaleH: CGFloat { get }
    var scaleW: CGFloat { get }
}

extension CGFloat: CGFloatProtocol {
    var scaleW: CGFloat {
        get {
            return self * (UIScreen.main.bounds.size.height / UIScreen.main.bounds.size.width)
        }
    }
    
    var scaleH: CGFloat {
        get {
            return self * (UIScreen.main.bounds.size.width / UIScreen.main.bounds.size.height)
        }
    }

    static var GA_M_2PI: CGFloat = 360 * CGFloat(Double.pi / 180)
    static var GA_M_PI: CGFloat = 180 * CGFloat(Double.pi / 180)
    static var GA_M_PI_2: CGFloat = 90 * CGFloat(Double.pi / 180)
    static var GA_M_PI_4: CGFloat = 45 * CGFloat(Double.pi / 180)
}

extension CGFloat {
    func toString() -> String {
        return String(describing: self)
    }
}

protocol ToCGFloatProtocol {
    var cgFloat: CGFloat { get }
}

extension Int: ToCGFloatProtocol {
    var cgFloat: CGFloat {
        get {
            return CGFloat(self)
        }
    }
    
    var color255: CGFloat {
        get {
            return CGFloat(self / 255)
        }
    }
}

extension Float: ToCGFloatProtocol {
    var cgFloat: CGFloat {
        get {
            return CGFloat(self)
        }
    }
}

extension Double: ToCGFloatProtocol {
    var cgFloat: CGFloat {
        get {
            return CGFloat(self)
        }
    }
}
