//
//  YYIMContactSelectionViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMContactSelectionViewController: YYBaseTableViewController {

    var occupants: [Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myTitle = "添加好友"
        self.showSearchBar = true
    }

    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal108
        registerNibWithIdentifier(YYIMAddFriendCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func textFieldShouldReturn(text: String) {
        if text != "" {
            self.dataSource.append(text)
            self.tableView.reloadData()
        }
    }
}

extension YYIMContactSelectionViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYIMAddFriendCell.identifier) as! YYIMAddFriendCell
        cell.userNameLabel.text = self.dataSource[indexPath.row] as? String
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let error = EMClient.shared().contactManager.addContact(self.dataSource[indexPath.row] as! String, message: "加加加！") else {
            self.view.ga_showView(text: "成功添加好友", deplay: 1)
            return
        }
        print("error: \(error)")
        self.view.ga_showView(text: "添加失败")
    }
}
