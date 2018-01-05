//
//  YYIMGroupCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYIMGroupCell: UITableViewCell {

    static let identifier: String = "YYIMGroupCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
