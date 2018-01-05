//
//  YYMyBasicCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYMyBasicCell: YYBaseTableViewCell {
    
    static let identifier = "YYMyBasicCell"
    static let height: CGFloat = 44
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var arrowsImageView: UIImageView!
    @IBOutlet weak var lineView: YYOnePixView!
    
    var dic: [String : Any]! {
        didSet {
            iconImageView.image = UIImage(named: dic[YYKey.myIcon] as! String)
            titleLabel.text = dic[YYKey.myTitle] as? String
            subTitleLabel.text = dic[YYKey.mySubtitle] as? String
            arrowsImageView.isHidden = !(dic[YYKey.myIsShowRightIcon] as! Bool)
            lineView.isHidden = !(dic[YYKey.myIsShowLineView] as! Bool)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
