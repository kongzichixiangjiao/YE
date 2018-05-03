//
//  View+GestureRecognizer.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/28.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

extension UIView {
    
    func yy_addTapGestureRecognizer(action: Selector?) {
        let tap = UITapGestureRecognizer(target: self, action: action)
        self.addGestureRecognizer(tap)
    }
    
    func yy_addLongPressGestureRecognizer(action: Selector?, duration: Double) {
        let longPress = UILongPressGestureRecognizer(target: self, action: action)
        longPress.minimumPressDuration = duration
        self.addGestureRecognizer(longPress)
    }
}

