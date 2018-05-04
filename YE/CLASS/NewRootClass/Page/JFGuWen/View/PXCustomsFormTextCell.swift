//
//  PXCustomsFormTextCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class PXCustomsFormTextCell: UICollectionViewCell {

    static let identifier = "PXCustomsFormTextCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var model: PXCustomsFormItemsModel! {
        didSet {
            titleLabel.text = model.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
