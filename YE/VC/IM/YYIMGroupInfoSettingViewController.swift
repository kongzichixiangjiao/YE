//
//  YYGroupInfoSettingViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/18.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYIMGroupInfoSettingViewController: YYBaseTableViewController {

    var group: EMGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "群详情设置"

        let arr = NSArray(contentsOfFile: Bundle.ga_path("IMGroupSetting.plist"))
        self.dataSource = arr as! [Any]
    }
    
    override func initTableView() {
        super.initTableView()
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYIMGroupInfoSettingCell.identifier)
        registerNibWithIdentifier(YYIMGroupInfoSettingButtonCell.identifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func clearAction(sender: UIButton) {
        
    }
    
    func quiteGroupAction(sender: UIButton) {
        
    }
    
}

extension YYIMGroupInfoSettingViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model: [String : Any] = self.dataSource[indexPath.row] as! [String : Any]
        if model[YYKey.type] as? Int == YYIMGroupInfoSettingType(rawValue: 1)?.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupInfoSettingCell.identifier) as! YYIMGroupInfoSettingCell
            if indexPath.row == 0 {
                cell.arrowImageView.isHidden = true
                cell.contentLabel.isHidden = false
                cell.contentLabel.text = self.group.groupId
            } else {
                cell.arrowImageView.isHidden = false
                cell.contentLabel.isHidden = true
            }
            cell.titleLabel.text = model["name"] as? String
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYIMGroupInfoSettingButtonCell.identifier) as! YYIMGroupInfoSettingButtonCell
            cell.button.setTitle(model[YYKey.name] as? String, for: .normal)
            if model[YYKey.name] as! String == YYKey.quiteGroup {
                cell.button.addTarget(self, action: #selector(quiteGroupAction(sender:)), for: .touchUpInside)
                cell.button.backgroundColor = "D7292A".color0X
            } else {
                cell.button.addTarget(self, action: #selector(clearAction(sender:)), for: .touchUpInside)
                cell.button.backgroundColor = "0076FF".color0X
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
