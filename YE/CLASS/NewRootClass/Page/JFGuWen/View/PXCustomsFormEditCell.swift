//
//  PXCustomsFormEditCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class PXCustomsFormEditCell: UICollectionViewCell, UITextFieldDelegate {
    
    static let identifier = "PXCustomsFormEditCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var model: PXCustomsFormItemsModel! {
        didSet {
            var kernValue = 0
            if (model.name.count == 2) {
                kernValue = 25
            } else if(model.name.count == 3) {
                kernValue = 6
            }
            let attributed = NSMutableAttributedString(string: model.name)
            attributed.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, attributed.length))
            attributed.addAttribute(NSAttributedStringKey.kern, value: kernValue, range: NSMakeRange(0, attributed.length - 1))
            titleLabel.attributedText = attributed
            
            textField.placeholder = model.placeText
            textField.text = model.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        model.text = textField.text!
    }
    
}
