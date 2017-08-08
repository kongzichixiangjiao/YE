//
//  YYIMGroupInfoSettingCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum YYIMGroupInfoSettingType: Int {
    case nomarl = 1, button = 2
}

class YYIMGroupInfoSettingCell: UITableViewCell {

    static let identifier = "YYIMGroupInfoSettingCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
