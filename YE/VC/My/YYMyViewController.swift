//
//  ViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class YYMyViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        
        initTableView()
        
        let _ = tableView.yy_addBaneHeaderView(.header, bgImage: UIImage(named: "cgts.jpg")!, height: YYBaneHeaderKey.kHeight, handler: {
            [weak self] in
            if let _ = self {
                
            }
        })
        
        tableView.setupHeaderViewData(UIImage(named: "cgts.jpg")!, userName: "huakunamtata")
        
        let arr = NSArray(contentsOfFile: Bundle.ga_path("my.plist"))
        self.dataSource = arr as! [Any]
    }
    
    func initNavigationView() {
        self.myTitle = "我的"
        self.isHiddenLeftButton = true
        self.setupRightButton(.mySetting)
    }
    
    override func initTableView() {
        saveAreaBottomSpaceType = .normal44
        registerNibWithIdentifier(YYMyBasicCell.identifier)
        registerNibWithIdentifier(YYSpaceCell.identifier)
        tableView.tableHeaderView = initModuleSelectedView()
    }
    
    func initModuleSelectedView() -> UIView {
        let v = YYModuleSelectedView(frame: CGRect(x: 0, y: kYYCircleScrollViewHeight, width: MainScreenWidth, height: kYYModuleSelectedCellHeight)) {
            [weak self] row in
            if let _ = self {
                print(row)
            }
        }
        v.data = [["title" : "我的报名", "icon" : "home_middle_activity"], ["title" : "我的成绩", "icon" : "home_middle_event"], ["title" : "我的保单", "icon" : "home_middle_live"], ["title" : "我发布的", "icon" : "home_middle_surrounding"]]
        return v
    }
    
    override func clickedNavigationViewRightButton(_ sender: UIButton) {
        super.clickedNavigationViewRightButton(sender)
        self.push(YYSettingViewController())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYMyViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYSpaceCell.identifier)
            return cell!
        }
        
        let dic = self.dataSource[indexPath.row - 1] as! [String : Any]
        if dic[YYKey.myType] as! Int == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYMyBasicCell.identifier) as! YYMyBasicCell
            cell.dic = dic
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: YYSpaceCell.identifier) as! YYSpaceCell
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 10
        }
        let dic = self.dataSource[indexPath.row - 1] as! [String : Any]
        if dic[YYKey.myType] as! Int == 0 {
            return YYMyBasicCell.height
        } else {
            return 15
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = YYApplyViewController()
            vc.myType = .linkman
            push(vc)
        }
        
        let dic = self.dataSource[indexPath.row - 1] as! [String : Any]
        
        if dic[YYKey.myTitle] as! String == "RxSwift" {
            let vc = YYRxSwiftViewController(nibName: "YYRxSwiftViewController", bundle: nil)
            push(vc)
        }
        if dic[YYKey.myTitle] as! String == "SwiftDate" {
            push(YYSwiftDateViewController(nibName: "YYSwiftDateViewController", bundle: nil))
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
