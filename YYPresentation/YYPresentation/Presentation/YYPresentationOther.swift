//
//  YYPresentationOther.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum YYTransitionType{
    case modalTransition(ModalOperation)
}

enum ModalOperation{
    case present, dismiss
}

// 弹出类型
public enum PresentationAnimationType {
    case none, downShow, upShow, middle, sheet, alert, bottom, top
}


