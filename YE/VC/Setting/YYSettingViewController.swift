
//
//  YYSettingViewController.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/8/2.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYSettingViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "设置"
        
        let _ = tableView.yy_addBaneHeaderView(.header, bgImage: UIImage(named: "cgts.jpg")!, height: YYBaneHeaderKey.kHeight, handler: {
            [weak self] in
            if let _ = self {
                
            }
        })
        
        tableView.setupHeaderViewData(UIImage(named: "cgts.jpg")!, userName: "")
        
        let arr = NSArray(contentsOfFile: Bundle.ga_path("setting.plist"))
        self.dataSource = arr as! [Any]
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
        registerNibWithIdentifier(YYSettingCell.identifier)
        tableView.tableFooterView = initTableFooterView()
    }
    
    func initTableFooterView() -> UIView {
        let b = "YYSettingFooterChangeButton".xibLoadView() as! UIButton
        b.frame = CGRect(x: 0, y: 0, width: MainScreenWidth, height: 60)
        b.addTarget(self, action: #selector(changeButtonAction), for: .touchUpInside)
        return b
    }
    
    @objc func changeButtonAction() {
        print("changed")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYSettingViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dic = self.dataSource[indexPath.row] as! [String : String]
        let cell = tableView.dequeueReusableCell(withIdentifier: YYSettingCell.identifier) as! YYSettingCell
        cell.keyLabel.text = dic["key"]
        cell.valueLabel.text = dic["value"]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return YYSettingCell.height
    }
}
