//
//  YYIMFriendCell.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/7/25.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYIMFriendCell: UITableViewCell {
    
    static let identifier = "YYIMFriendCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedButton: UIButton!
    
    @IBAction func selectedButtonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
