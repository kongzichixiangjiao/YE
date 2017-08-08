//
//  YYCompetitionCommentSection.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionCommentSectionView: UIView {
    
    var model: YYCompetitionCommentSectionModel! {
        didSet {
            titleLabel.text = model.title
            likeButton.isSelected = model.isLike
            likeNumberLabel.text = String(model.likeNumber)
            contentLabel.attributedText = NSAttributedString.yy_contentStyle(text: model.content)
        }
    }
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var contentLabel: UILabel!

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeNumberLabel: UILabel!
    
    @IBAction func likeAction(_ sender: UIButton) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
