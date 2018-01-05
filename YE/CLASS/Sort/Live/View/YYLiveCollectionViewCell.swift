//
//  YYLiveCollectionViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYLiveCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "YYLiveCollectionViewCell"
    
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
