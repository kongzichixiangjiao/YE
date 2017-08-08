//
//  YYApplyAddImageTableViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/26.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYApplyAddImageTableViewCell: UITableViewCell {

    static var identifier = "YYApplyAddImageTableViewCell"
    
    weak var myDelegate: YYApplyAddImageTableViewCellDelegate?
    
    var myRow: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var model: YYApplyModel! {
        didSet {
            titleLabel.text = model.key
            for (i, data) in model.imageData!.enumerated() {
                if data.count != 3 {
                    (self.stackView.arrangedSubviews[i] as! UIButton).setImage(UIImage(data: data), for: .normal)
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func selectedAction(_ sender: UIButton) {
        self.myDelegate?.didSelectedImage(tag: sender.tag - 1, row: self.myRow!)
        
    }
    
}
