//
//  YYEaseConversationListViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/13.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYEaseConversationListViewController: EaseConversationListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showRefreshHeader = true
        
        self.tableViewDidTriggerHeaderRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
