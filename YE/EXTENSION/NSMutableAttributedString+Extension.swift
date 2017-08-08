//
//  NSMutableAttributedString+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    class func yy_paragraphStyle() -> NSMutableParagraphStyle {
        let style                 = NSMutableParagraphStyle()
        style.lineSpacing         = 5.0 //每行文字之间的距离
        style.paragraphSpacing    = 5.0 //段落之间的距离
        style.headIndent          = 0.0 //每一行前面缩进的距离
        style.firstLineHeadIndent = 0.0 //每段开头缩进
        return style
    }
    
    class func yy_contentStyle(text: String) -> NSAttributedString {
        let attributed = NSMutableAttributedString(string: text)
        let style = yy_paragraphStyle()
        attributed.addAttributes([NSParagraphStyleAttributeName : style], range: NSMakeRange(0, attributed.length))
        return attributed
    }

}
