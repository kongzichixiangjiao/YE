//
//  PXCustomsFormImageCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class PXCustomsFormImageCell: UICollectionViewCell {

    static let identifier = "PXCustomsFormImageCell"
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var topBackView: UIView!
    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var dataImageView: UIImageView!
    
    var model: PXCustomsFormItemsModel! {
        didSet {
            textLabel.text = model.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = CGRect(x: 0, y: 0, width: MainScreenWidth - 60 - 15, height: self.topBackView.bounds.height)
        let rect_bottom = CGRect(x: 0, y: 0, width: MainScreenWidth - 60 - 15, height: self.bottomBackView.bounds.height)
        
        setupCornerRadii(rect: rect, maskView: self.topBackView, radii: 5, byRoundingCorners: [.topLeft, .topRight])
        setupCornerRadii(rect: rect_bottom, maskView: self.bottomBackView, radii: 5, byRoundingCorners: [.bottomLeft, .bottomRight])
    }
    
    func setupCornerRadii(rect: CGRect, maskView: UIView, radii: CGFloat, byRoundingCorners: UIRectCorner) {
        let maskPath_bottom = UIBezierPath(roundedRect: rect, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer_bottom = CAShapeLayer()
        maskLayer_bottom.frame = rect
        maskLayer_bottom.path = maskPath_bottom.cgPath
        maskView.layer.mask = maskLayer_bottom
    }

}
