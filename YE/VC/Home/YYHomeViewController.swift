//
//  YYYeEventViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYHomeViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func initNavigationView() {
        self.myTitle = "首页"
        self.leftButtonTitle = "home_nav_scan"
    }
    
    override func initTableView() {
        isShowTabbar = true
        tableViewFrameType = .normal64
//        registerNibWithIdentifier(kYYHomeBasicCell)
        
        registerClassWithIdentifier(YYDrawerTableViewCellNew.identifier)
        
        tableView.tableHeaderView = initTableViewHeaderView()
        self.footerView()
    }
    
    func initTableViewHeaderView() -> UIView {
        let w: CGFloat = tableView.frame.size.width
        
        let tableHeaderView = YYHomeTopView(frame: CGRect(x: 0, y: 0, width: w, height: kYYCircleScrollViewHeight + kYYModuleSelectedCellHeight + 10)) {
            [weak self] row in
            if let weakSelf = self {
                weakSelf.topViewModuleSelected(row: row)
            }
        }
        tableHeaderView.showLineView(space: 10)
        
        let imageNames = ["IMG_2787.jpg", "IMG_3260.JPG", "IMG_2719.jpg", "IMG_3027.jpg"]
        tableHeaderView.imageNames = imageNames
        tableHeaderView.data = [["title" : "活动", "icon" : "home_middle_activity"], ["title" : "直播", "icon" : "home_middle_live"], ["title" : "周边", "icon" : "home_middle_surrounding"], ["title" : "文章", "icon" : "home_middle_article"]]
        
        return tableHeaderView
    }
    
    // MARK: 轮播广告图点击事件
    func topViewModuleSelected(row: Int) {
        switch row {
        case 0:
            self.push(vc: YYActivityListViewController())
            break
        case 1:
            self.push(vc: YYCompetitionListViewController())
            break
        case 2:
            self.push(vc: YYLiveListViewController())
            break
        case 3:
            self.push(vc: YYSurroundingListViewController())
            break
        case 4:
            self.push(vc: YYArticleListViewController())
            break
        default:
            break
        }
    }
    
    // MARK: 扫码事件
    override func clickedLeftButtonAction() {
        print("扫码")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension YYHomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = YYDrawerTableViewCellNew.custom(tableView: tableView, handler: {
            [weak self] row, obj in
            if let _ = self {
                print("row: \(row)")
                let vc = YYAlertViewController()
                if row == 0 {
                    vc.yy_showText(text: "佳能 佳能佳能")
                } else if (row == 1) {
                    vc.yy_showLoading()
                } else if (row == 2) {
                    vc.yy_showImage_text(imageType: .error, text: "成功成功成功")
                } else if (row == 3) {
                    vc.yy_showSelected(title: "佳能6D2", data: ["1", "2", "3"], handler: {
                        [weak self] row, value in
                        if let _ = self {
                            print("row: \(row), value: \(String(describing: value))")
                        }
                    })
                } else {
                    
                }
            }
        }) {
            [weak self] tag in
            if let _ = self {
                print("tag: \(tag)")
            }
        }
        cell.myRow = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return Bundle.main.loadNibNamed("YYHomeSectionView", owner: self, options: nil)?.last as? UIView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            self.view.ga_showSelectedLoading(data: ["12", "22", "32", "42", "52"], handler: { (row, obj) in
                print(row, obj ?? "")
            })
        } else if (indexPath.row == 1) {
            print(self.view.alertWhiteWindow)
        } else {
            self.view.ga_hideSelectedLoading()
        }
    }
}
