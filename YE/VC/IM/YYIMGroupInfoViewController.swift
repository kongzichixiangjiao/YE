//
//  GroupInfoViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMGroupInfoViewController: YYBaseTableViewController {
    
    fileprivate let kGroupOwnerSection: Int = 0
    fileprivate let kGroupMembersSection: Int = 1
    
    var groupId: String!
    var group: EMGroup!
    var showMembers: [Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "群详情"
        
        self.setupRightButton(.imSetting)
        
        requestGroupInfo()
        
        initAddFriendButton()
    }
    
    func initAddFriendButton() {
        let w: CGFloat = 60
        let space: CGFloat = 15
        let v = "YYIMDetailsAddFriendButton".xibLoadView() as! UIButton
        v.frame = CGRect(x: MainScreenWidth - w - space, y: MainScreenHeight - TabBarHeight - w - space, width: w, height: w)
        v.addTarget(self, action: #selector(addFriendButtonAction(_:)), for: .touchUpInside)
        self.view.addSubview(v)
    }
    
    @objc func addFriendButtonAction(_ sender: UIButton) {
        let vc = YYIMFriendListViewController()
        vc.group = group
        vc.isCanSelected = true
        self.push(vc)
    }
    
    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYIMGroupInfoCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestGroupInfo() {
        DispatchQueue.global().async {
            [weak self] in
            if let weakSelf = self {
                var error: EMError? = EMError()
                guard let group: EMGroup = EMClient.shared().groupManager.getGroupSpecificationFromServer(withId: weakSelf.groupId, error: &error) else {
                    print("error: \(String(describing: error?.errorDescription))")
                    return
                }
                
                print("groupId: \(group.groupId)")
                weakSelf.group = group
                let conversation = EMClient.shared().chatManager.getConversation(group.groupId, type: EMConversationTypeGroupChat, createIfNotExist: true)
                if group.groupId == conversation?.conversationId {
                    let ext = ["subject" : group.subject, "isPublic" : group.isPublic] as [String : Any]
                    conversation?.ext = ext
                }
                
                DispatchQueue.main.async {
                    weakSelf.getGroupMemberList()
                }
            }
        }
    }
    
    func getGroupMemberList() {
        EMClient.shared().groupManager.getGroupMemberListFromServer(withId: self.groupId, cursor: "", pageSize: 10) {
            [weak self] result, error in
            if let weakSelf = self {
                if let e = error {
                    print("error: \(e)")
                }
                if let r = result {
                    print(r.list)
                    weakSelf.showMembers = r.list
                    weakSelf.tableView.reloadData()
                }
            }
        }
    }
    
    override func clickedRightButtonAction(_ sender: UIButton) {
        let vc = YYIMGroupInfoSettingViewController()
        vc.group = self.group
        self.push(vc)
    }
    func addMemberAction() {
        let occupants = [self.group.owner, self.group.adminList, self.group.memberList] as [Any]
        let vc = YYIMContactSelectionViewController()
        vc.occupants = occupants
    }
    
}

extension YYIMGroupInfoViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupInfoCell.identifier) as! YYIMGroupInfoCell
        if let group = self.group {
            if indexPath.section == kGroupOwnerSection {
                if indexPath.row == 0 {
                    cell.userNameLabel.text = group.owner
                    cell.positionLabel.text = "群主"
                } else {
                    cell.userNameLabel.text = self.group.adminList[indexPath.row - 1] as? String
                    cell.positionLabel.text = "群管理"
                }
            } else {
                cell.userNameLabel.text = self.group.memberList[indexPath.row] as? String
                cell.positionLabel.text = ""
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = YYIMGroupInfoSectionView.xibView()
        v.titleLabel.text = section == kGroupOwnerSection ? "群主/群管理" : "群成员"
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let group = self.group else {
            return 0
        }
        return section == kGroupOwnerSection ? 1 + group.adminList.count : group.memberList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
