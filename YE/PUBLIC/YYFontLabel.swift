//
//  YYFontLabel.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import DeviceKit

class YYFontLabel: UILabel {
    
    @IBInspectable var font_5s: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let device = Device()
        switch device {
        case .simulator(.iPhone5s), .simulator(.iPhone5), .simulator(.iPhone5c), .iPhone5, .iPhone5c, .iPhone5s:
            self.font = UIFont.systemFont(ofSize: font_5s)
            break
        default:
            break
        }
        
    }
    
}
