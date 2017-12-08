//
//  YYYeEventViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

enum YYEventShotViewList: String {
    case creatGroup = "创建野事儿", addFriend = "添加野友", presentStepNumber = "送步数"
}

class YYYeEventViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        
        initTableView()
        
        let groupVC = YYIMGroupListViewController()
        groupVC.title = "群组"
        groupVC.delegate = self
        let friendVC = YYIMFriendListViewController()
        friendVC.title = "好友"
        friendVC.delegate = self
        let pageView = YYPagingView(frame: CGRect(x: 0, y: navigationView.maxY, width: MainScreenWidth, height: MainScreenHeight - NavigationViewHeight), vcs: [groupVC, friendVC]) { (tag) in
            print("tag: \(tag)")
        }
        self.view.addSubview(pageView)
    }
    
    func initNavigationView() {
        self.myTitle = "野事er"
        self.isHiddenLeftButton = true
        self.setupRightButton(.add)
    }
    
    override func initTableView() {
//        tableViewFrameType = .normal44
//        registerNibWithIdentifier(YYIMGroupCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func clickedRightButtonAction(_ sender: UIButton) {
        YYShotView.show(sender, items: [YYEventShotViewList.creatGroup.rawValue, YYEventShotViewList.addFriend.rawValue, YYEventShotViewList.presentStepNumber.rawValue]) {
            [weak self] title in
            if let weakSelf = self {
                weakSelf.clickedShotViewList(title)
            }
        }
    }
    
    func clickedShotViewList(_ title: String) {
        switch title {
        case YYEventShotViewList.creatGroup.rawValue:
            self.push(YYIMCreatChatGroupViewController())
            break
        case YYEventShotViewList.addFriend.rawValue:
            self.push(YYIMContactSelectionViewController())
            break
        case YYEventShotViewList.presentStepNumber.rawValue:
            break
        default:
            break 
        }
    }
}

extension YYYeEventViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupCell.identifier) as! YYIMGroupCell
        let group = self.dataSource[indexPath.row] as! EMGroup
        cell.titleLabel.text = group.subject
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YYIMGroupInfoViewController()
        vc.groupId = (self.dataSource[indexPath.row] as! EMGroup).groupId
        self.push(vc)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension YYYeEventViewController: YYPushDelegate {
    func pushAction(_ model: Any, type: YYPushDelegateType) {
        switch type {
        case .group:
            let vc = YYIMGroupViewController(conversationChatter: (model as! EMGroup).groupId, conversationType: EMConversationTypeGroupChat)
            vc?.group = model as! EMGroup
            self.push(vc!)
            break
        case .friend:
            let vc = YYIMConversationViewController(conversationChatter: (model as! EaseUserModel).buddy, conversationType: EMConversationTypeChat)
            self.push(vc!)
            break
        }
    }
}
