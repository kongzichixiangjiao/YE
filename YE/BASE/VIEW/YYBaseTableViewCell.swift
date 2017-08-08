//
//  YYBaseTableViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYBaseTableViewCell: UITableViewCell {

    @IBInspectable var lineViewSpace: CGFloat = 0
    @IBInspectable var lineViewColor: UIColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.showLineView(space: lineViewSpace, position: .bottom, color: lineViewColor)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
