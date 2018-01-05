//
//  YYIMFriendViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/13.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMFriendListViewController: YYBaseTableViewController {
    
    var group: EMGroup!
    
    var isCanSelected: Bool = false
    var selectedData: [Any] = []
    
    weak var delegate: YYPushDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if isCanSelected {
            self.myTitle = "选择好友"
            self.setupRightButton(.finished)
        }
        
        initTableView()
        
        EMClient.shared().contactManager.add(self, delegateQueue: nil)
        
        self.tableView.ga_addRefreshHeaderXIB(GA_AnimationRefreshHeaderView.loadView()) {
            [weak self] in
            if let weakSelf = self {
                weakSelf.refreshFriendList()
            }
        }
        self.tableView.ga_XIBbeginRefreshing()
    }
    
    func refreshFriendList() {
        dataSource.removeAll()
        requestFriendList()
    }
    
    func requestFriendList() {
        
        DispatchQueue.global().async {
            var error: EMError? = EMError()
            let friends = EMClient.shared().contactManager.getContactsFromServerWithError(&error)
            DispatchQueue.main.async {
                guard let e = error else {
                    
                    for buddy in friends! {
                        let model = EaseUserModel(buddy: buddy as! String)
                        self.dataSource.append(model!)
                    }
                    
                    self.tableView.reloadData()
                    self.tableView.ga_XIBendRefreshing()
                    return
                }
                print("error: \(e)")
                self.tableView.ga_XIBendRefreshing()
            }
        }
    }
    
    override func clickedRightButtonAction(_ sender: UIButton) {
        super.clickedRightButtonAction(sender)
        DispatchQueue.global().async {
            [weak self] in
            if let weakSelf = self {
                var error: EMError? = EMError()
                var buddys: [String] = []
                for model in weakSelf.selectedData {
                    buddys.append((model as! EaseUserModel).buddy)
                }
                EMClient.shared().groupManager.addOccupants(buddys, toGroup: weakSelf.group.groupId, welcomeMessage: "欢迎进群", error: &error)
                DispatchQueue.main.async {
                    if let e = error {
                        print("error: \(e.errorDescription)")
                        weakSelf.view.ga_showView("加入失败", deplay: 0.3)
                    }
                    weakSelf.view.ga_showView("成功入坑", deplay: 0.3)
                }
            }
        }
    }
    
    override func initTableView() {
        super.initTableView()
        isCancleX = true
        saveAreaBottomSpaceType = isCanSelected ? .normal44 : .normal0
        registerNibWithIdentifier(YYIMFriendCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYIMFriendListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYIMFriendCell = tableView.dequeueReusableCell(withIdentifier: YYIMFriendCell.identifier) as! YYIMFriendCell
        let model = self.dataSource[indexPath.row] as! EaseUserModel
        cell.titleLabel.text = model.buddy
        cell.selectedButton.isHidden = !isCanSelected
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row] as! EaseUserModel
        let cell = tableView.cellForRow(at: indexPath) as! YYIMFriendCell
        cell.selectedButton.isSelected = !cell.selectedButton.isSelected
        if (isCanSelected) {
            if cell.selectedButton.isSelected {
                selectedData.append(model)
            } else {
                let arr = selectedData
                for (i, obj) in arr.enumerated() {
                    if model.buddy == (obj as! EaseUserModel).buddy {
                        self.selectedData.remove(at: i)
                    }
                }
            }
            self.rightButtonIsEnabled = selectedData.count > 0
        } else {
            delegate?.pushAction(model, type: .friend)
        }
    }
}

extension YYIMFriendListViewController: EMContactManagerDelegate {
    // 同意加好友
    func friendRequestDidApprove(byUser aUsername: String!) {
        
    }
    
    // 拒绝加好友
    func friendRequestDidDecline(byUser aUsername: String!) {
        
    }
    
    // 删除好友
    func friendshipDidRemove(byUser aUsername: String!) {
        
    }
    
    // 申请好友
    func friendshipDidAdd(byUser aUsername: String!) {
        
    }
    
    // 收到申请好友
    func friendRequestDidReceive(fromUser aUsername: String!, message aMessage: String!) {
        
    }
    
}
