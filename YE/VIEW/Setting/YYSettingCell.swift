//
//  YYSettingCell.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/8/2.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYSettingCell: UITableViewCell {

    static let identifier = "YYSettingCell"
    static let height: CGFloat = 44
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
