//
//  Protocol.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/6.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import UIKit

protocol YYApplyContentDelegate: NSObjectProtocol {
    func finishedContent(content: String?, andRow row: Int)
}

protocol YYWebViewDelegate: NSObjectProtocol {
    func webViewDidFinish(height: CGFloat)
}

protocol YYCompetitionDetailsBottomViewDelegate: NSObjectProtocol {
    // 报名查询
    func applyQuery(id: String)
    func apply(id: String)
}

protocol YYApplyAddImageTableViewCellDelegate: NSObjectProtocol {
    func didSelectedImage(tag: Int, row: Int)
}


enum YYPushDelegateType: Int {
    case group, friend
}

protocol YYPushDelegate: NSObjectProtocol {
    func pushAction(model: Any, type: YYPushDelegateType)
}
