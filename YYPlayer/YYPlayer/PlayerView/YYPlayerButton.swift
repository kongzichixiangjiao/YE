//
//  YYPlayerButton.swift
//  YYPlayer
//
//  Created by 侯佳男 on 2018/5/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

// MARK: YYPlayerButton
open class YYPlayerButton: UIButton {
    
    open var playState: YYPlayerState = .pause {
        didSet {
            switch playState {
            case .play:
                self.isSelected = true
            case .pause:
                self.isSelected = false
            case .unknow:
                print("更改状态时候发生未知错误")
            case .stop:
                break
            case .finished:
                break
            }
        }
    }
    
    open var fullState: YYPlayerScreenState = .small {
        didSet {
            switch fullState {
            case .full:
                self.isSelected = true
            case .small:
                self.isSelected = false
            }
        }
    }
}

