//
//  YYRxSwiftViewCell.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYRxSwiftViewCell: UITableViewCell {

    static let identifier = "YYRxSwiftViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var model: YYRxSwiftNewsListModel! {
        didSet {
            titleLabel.text = model.title
        }
    }
    
}
