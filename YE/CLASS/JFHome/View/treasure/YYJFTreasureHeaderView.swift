//
//  YYJFTreasureHeaderView.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/9.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYJFTreasureHeaderView: UICollectionReusableView {

    static let identifier = "YYJFTreasureHeaderView"
    static let height: CGFloat = 230
    
    @IBOutlet weak var allMoneyLabel: UILabel!
    @IBOutlet weak var eyeButton: UIButton!
    
    var allMoney: String! {
        didSet {
            if eyeButton.isSelected {
                allMoneyLabel.text = allMoney == "" ? "0" : allMoney
            } else {
                allMoneyLabel.text = "******"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func eyeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (sender.isSelected) {
            allMoneyLabel.text = allMoney == "" ? "0" : allMoney
        } else {
            allMoneyLabel.text = "******"
        }
    }
}
