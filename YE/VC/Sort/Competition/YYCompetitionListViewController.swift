//
//  YYCompetitionListViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionListViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "赛事"
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYCompetitionListCell.identifier)
        self.footerView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension YYCompetitionListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYCompetitionListCell.identifier)
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YYCompetitionListCell.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(vc: YYCompetitionDetailsViewController())
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
