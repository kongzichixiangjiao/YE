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
    
    @IBOutlet weak var subtileLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var lineView: YYOnePixView!
    
    var model: PXCustomsFormModel! {
        didSet {
            subtileLabel.isHidden = !model.isSelected
            iconImageView.isHidden = !model.isSelected
            titleLabel.text = model.title
            subtileLabel.text = model.subtitle
            lineView.isHidden = !model.isShowLine
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func clickAction(_ sender: UIButton) {
        if (model.isSelected) {
            return
        }
    }
}
