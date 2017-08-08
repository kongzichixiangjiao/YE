//
//  YYApplyTextTableViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/5.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYApplyTextTableViewCell: YYBaseTableViewCell {
    
    static var identifier = "YYApplyTextTableViewCell"
    
    weak var myDelegate: YYApplyContentDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mustImageView: UIImageView!
    @IBOutlet weak var contentTextField: UITextField!
    
    var row: Int!
    var content: String! {
        get{
            return contentTextField.text!
        }
    }
    
    var model: YYApplyModel! {
        didSet {
            titleLabel.text = model.key
            contentTextField.text = model.value
            contentTextField.placeholder = model.placeholder
            mustImageView.isHidden = !model.must
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentTextField.delegate = self;
    }
    
}

extension YYApplyTextTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.model.value = textField.text
        myDelegate?.finishedContent(content: textField.text, andRow: row)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
