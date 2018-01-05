//
//  YYApplyQueryViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/21.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYApplyQueryViewController: YYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "报名查询";
        
        initSearchTextfield()
    }
    
    func initSearchTextfield() {
        let space: CGFloat = 20
        let s = UITextField()
        s.frame = CGRect(x: space, y: NavigationViewHeight, width: MainScreenWidth - space * 2, height: 32)
        s.delegate = self;
        self.view.addSubview(s)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}

extension YYApplyQueryViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
