//
//  YYCompetitionDetailsBottomView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/20.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionDetailsBottomView: UIView {

    static let height: CGFloat = 40
    
    weak var myDelegate: YYCompetitionDetailsBottomViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commentTextField.delegate = self
    }
    
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var demandButton: UIButton!
    
    @IBAction func applyAction(_ sender: UIButton) {
        self.myDelegate?.apply(id: "")
    }
    
    @IBAction func demandAction(_ sender: UIButton) {
        self.myDelegate?.applyQuery(id: "")
    }
    
    public func hideBottomView() {
        UIView.animate(withDuration: 0.3) { 
            self.frame = CGRect(x: 0, y: MainScreenHeight - TabBarHeight, width: MainScreenWidth, height: YYCompetitionDetailsBottomView.height)
        }
        myResignFirstResponder()
    }
    
    public func showBottomView() {
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: 0, y: MainScreenHeight - YYCompetitionDetailsBottomView.height - TabBarHeight, width: MainScreenWidth, height: YYCompetitionDetailsBottomView.height)
        }
    }
    
    public func myResignFirstResponder() {
        self.commentTextField.resignFirstResponder()
    }
}

extension YYCompetitionDetailsBottomView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
