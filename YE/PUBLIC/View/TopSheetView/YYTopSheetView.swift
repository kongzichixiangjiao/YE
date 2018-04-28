//
//  YYTopSheetView.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/27.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYTopSheetView: UIView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var text: String! {
        didSet {
            messageLabel.text = text 
        }
    }
    
    var type: YYTopSheetType! {
        didSet {
            switch type {
            case .error:
                self.iconImageView.image = UIImage(named: "topSheet_error")
                break
            case .finished:
                self.iconImageView.image = UIImage(named: "")
                break
            case .message:
                self.iconImageView.image = UIImage(named: "topSheet_alert")
                break
            case .none:
                break
            case .some(_):
                break
            }
            
        }
    }
}
