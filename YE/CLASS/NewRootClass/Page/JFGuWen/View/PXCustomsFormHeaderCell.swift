//
//  PXCustomsFormHeaderCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class PXCustomsFormHeaderCell: UICollectionReusableView {

    static let identifier = "PXCustomsFormHeaderCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: PXCustomsFormModel! {
        didSet {
            titleLabel.text = model.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
