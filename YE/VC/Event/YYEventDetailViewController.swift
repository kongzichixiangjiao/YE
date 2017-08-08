//
//  YYEventDetailViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYEventDetailViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationView.myTitle = "详情"

        let playerView = YYPlayerView(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 240))
        playerView.backgroundColor = UIColor.white
        
        self.tableView.tableHeaderView = playerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
