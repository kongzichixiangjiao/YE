//
//  YYApplySelectedTableViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYApplySelectedTableViewCell: YYBaseTableViewCell {

    static var identifier = "YYApplySelectedTableViewCell"
    
    weak var myDelegate: YYApplyContentDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mustImageView: UIImageView!
    @IBOutlet weak var contentButton: UIButton!
    
    var model: YYApplyModel! {
        didSet {
            titleLabel.text = model.key
            if model.value != "" {
                contentButton.setTitle(model.value, for: .normal)
                contentButton.setTitleColor(UIColor.black, for: .normal)
            } else {
                contentButton.setTitle(model.placeholder, for: .normal)
                contentButton.setTitleColor(UIColor.darkGray, for: .normal)
            }
            mustImageView.isHidden = !model.must
        }
    }

    
    @IBAction func clickedContentButton(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
