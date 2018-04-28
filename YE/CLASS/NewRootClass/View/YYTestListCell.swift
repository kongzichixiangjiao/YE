//
//  YYTestListCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYTestListCell: UITableViewCell {

    static let identifier = "YYTestListCell"
    
    @IBOutlet weak var tLabel: UILabel!
    
    var model: YYTestListModel! {
        didSet {
            self.tLabel.text = model.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
