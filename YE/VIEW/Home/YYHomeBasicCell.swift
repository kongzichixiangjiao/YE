//
//  YYHomeBasicCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

public let kYYHomeBasicCell = "YYHomeBasicCell"

class YYHomeBasicCell: YYBaseTableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.showLineView(space: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
