//
//  YYAlertSelectedCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

public var kYYAlertSelectedCell = "YYAlertSelectedCell"
public var kYYAlertSelectedCellHeight: CGFloat = 44

class YYAlertSelectedCell: YYBaseTableViewCell {

    static let height: CGFloat = 44
    
    @IBOutlet weak var myTitleLabel: UILabel!
    
    var myTitle: String! {
        didSet {
            self.myTitleLabel.text = myTitle
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
