//
//  YYAlertSelectedTableViewHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

public var kYYAlertSelectedTableViewHeaderViewHeight: CGFloat = 30

class YYAlertSelectedTableViewHeaderView: UIView {

    static let height: CGFloat = 30
    
    var myTitle: String! {
        didSet {
            self.myTitleLabel.text = myTitle
        }
    }
    
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var closed: UIButton!
    @IBAction func closedAction(_ sender: UIButton) {
        
    }

}
