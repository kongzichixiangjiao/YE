//
//  YYSearchBar.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/7.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYSearchBarDelegate: class {
    func searchBarDidBeginEditing(text: String)
    func searchBarChangedValue(text: String)
    func searchBarDidEndEditing(text: String)
    
    func searchBarClickedCancleButton()
}

class YYSearchBar: UIView {

    weak var delegate: YYSearchBarDelegate?
    
    static let height: CGFloat = 44
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var cancleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
    static func loadView() -> YYSearchBar {
        return Bundle.main.loadNibNamed("YYSearchBar", owner: self, options: nil)?.last as! YYSearchBar
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.searchBarChangedValue(text: sender.text!)
    }
    
    @IBAction func cancleAction(_ sender: UIButton) {
        delegate?.searchBarClickedCancleButton()
        
        showCancleButton(isShow: false)
        
        textField.resignFirstResponder()
    }
    
    func showCancleButton(isShow: Bool) {
        self.rightConstraint.constant = isShow ? 60 : 0
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
        
        textField.text = ""
    }
}

extension YYSearchBar: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.searchBarDidBeginEditing(text: textField.text!)
        showCancleButton(isShow: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.searchBarDidEndEditing(text: textField.text!)
        showCancleButton(isShow: false)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}
