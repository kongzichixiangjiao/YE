//
//  YYIMRoomViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMRoomViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //EMChatroomManagerDelegate
        //注册聊天室回调
        EMClient.shared().roomManager.add(self, delegateQueue: nil)
        
        initNavigationView()
        
        hx_roomList()
    }
    
    func initNavigationView() {
        self.myTitle = "聊天室"
    }
    
    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYIMGroupCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hx_roomList() {
        
        EMClient.shared().roomManager.getChatroomsFromServer(withPage: 1, pageSize: 10) { (pageResult, error) in
            if let e = error {
                print("error: \(String(describing: e))")
                return
            }
            self.dataSource = pageResult!.list
            self.tableView.reloadData()
        }
    }
    
    deinit {
        //移除；聊天室回调
        EMClient.shared().roomManager.remove(self)
    }

}

extension YYIMRoomViewController: EMChatroomManagerDelegate {
    
}

extension YYIMRoomViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYIMGroupCell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupCell.identifier) as! YYIMGroupCell
        cell.titleLabel.text = String(describing: self.dataSource[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            hx_roomList()
            break
        case 1:
            
            break
        default:
            break
        }
        
    }
}
