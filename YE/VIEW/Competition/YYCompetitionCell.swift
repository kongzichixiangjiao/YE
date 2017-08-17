//
//  YYCompetitionCell.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionCell: UITableViewCell {

    static let identifier: String = "YYCompetitionCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
