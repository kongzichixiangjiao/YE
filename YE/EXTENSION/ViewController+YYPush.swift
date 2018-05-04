//
//  ViewController+YYPush.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation

extension UIViewController {
    func yy_getTargetVC(vcName: String) -> UIViewController? {
        switch vcName {
        case YYTestListPushType.topSheet.rawValue:
            return YYTopSheetViewController(nibName: vcName, bundle: nil)
        case YYTestListPushType.jfHome.rawValue:
            return YYJFHomeViewController()
        case YYTestListPushType.sourceTransition.rawValue:
            return YYSourceTransitionViewController(nibName: vcName, bundle: nil)
        case YYTestListPushType.player.rawValue:
            return YYPlayerViewController(nibName: vcName, bundle: nil)
            case YYTestListPushType.customsForm.rawValue:
            return PXCustomsFormViewController()
        default:
            break
        }
        return nil
    }
}
