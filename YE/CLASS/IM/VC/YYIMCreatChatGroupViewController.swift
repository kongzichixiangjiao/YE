//
//  YYIMCreatChatGroupViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/17.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMCreatChatGroupViewController: YYBaseViewController {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var groupContenTextView: UITextView!
    @IBOutlet weak var groupJurisdictionSwitch: UISwitch!
    @IBOutlet weak var groupJurisdictionLabel: UILabel!
    @IBOutlet weak var memberAddJurisdictionSwitch: UISwitch!
    @IBOutlet weak var memberAddJurisdictionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "创建野事儿"
    }
    
    @IBAction func finishedAction(_ sender: UIButton) {
        createChatGroup()
    }
    
    func createChatGroup() {
        
        HXManager.share.hx_createChatGroup(groupJurisdictionSwitch.isOn, isMemberAddJurisdiction: memberAddJurisdictionSwitch.isOn, subject: groupNameTextField.text!, description: groupContenTextView.text, message: "加入吧 骚年") { (success) in
            if success {
                self.view.ga_showView("创建成功", deplay: 0.5)
                return
            }
            self.view.ga_showView("失败！！", deplay: 0.5)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        myRegignFirstResponder()
    }
    
    fileprivate func myRegignFirstResponder() {
        groupNameTextField.resignFirstResponder()
        groupContenTextView.resignFirstResponder()
    }
    
}
