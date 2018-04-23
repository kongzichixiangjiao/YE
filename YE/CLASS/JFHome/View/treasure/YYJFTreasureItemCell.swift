//
//  YYJFTreasureItemCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/9.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYJFTreasureItemCell: UICollectionViewCell {

    static let identifier = "YYJFTreasureItemCell"
    static let height: CGFloat = 86
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
