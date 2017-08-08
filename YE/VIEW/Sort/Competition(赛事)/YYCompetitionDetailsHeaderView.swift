//
//  YYCompetitionDetailsHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionDetailsHeaderView: UIView {
    
    static let height: CGFloat = 270

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tileLabel: YYIconLableView!
    @IBOutlet weak var placeLabel: YYIconLableView!
    
    @IBOutlet weak var likeNumberLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func likeAction(_ sender: UIButton) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showLineView(space: 0)
    }
}
