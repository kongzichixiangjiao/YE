//
//  YYCompetitionViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class YYCompetitionViewController: YYBaseTableViewController {
    
    var dataArr: [YYPXHotSpot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        initTableView()
        
        self.tableView.ga_addRefreshHeaderXIB(GA_AnimationRefreshHeaderView.loadView()) {
            [weak self] in
            if let weakSelf = self {
                print("开始刷新")
                weakSelf.requestData()
            }
        }
        
        self.tableView.ga_addLoadFooter(GA_LoadMoreView()) {
            [weak self] in
            if let weakSelf = self {
                weakSelf.requestMoreData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if dataArr.count == 0 {
            self.tableView.ga_XIBbeginRefreshing()
        }
    }
    
    func initNavigationView() {
        self.myTitle = "赛事"
        self.isHiddenLeftButton = true
        self.setupOtherRightButton(title: "连拍")
    }
    
    override func initTableView() {
        isShowTabbar = true
        saveAreaBottomSpaceType = .normal44
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = true 
        registerNibWithIdentifier(YYCompetitionCell.identifier)
    }
    
    override func clickedNavigationViewOtherRightButton(_ sender: UIButton) {
        push(YYCameraViewController())
    }
    
    func requestMoreData() {
        request(isMore: true)
    }
    
    func requestData() {
        request(isMore: false)
    }
    
    func request(isMore: Bool) {
//        self.view.ga_showLoading()
        YYRequest.share.request(target: .jf_cjzh, success: { (request) in
//            self.view.ga_hideLoading()
            if let model = YYPXBaseModel.deserialize(from: request.resultDic) {
                self.view.ga_showView(model.myMessage!, deplay: 1.2)
                if isMore {
                    self.dataArr += model.result?.hotspot ?? []
                    self.tableView.reloadData()
                    self.tableView.ga_endLoadFooter()
                } else {
                    self.dataArr = model.result?.hotspot ?? []
                    self.dataArr.append((model.result?.hotspot!.first!)!)
                    self.tableView.reloadData()
                    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                        DispatchQueue.main.async {
                            self.tableView.ga_XIBendRefreshing()
                        }
                    })
                }
            }
        }) { (code, error) in
//            self.view.ga_hideLoading()
            self.view.showView(error + String(code))
            self.tableView.ga_XIBendRefreshing()
            self.tableView.ga_endLoadFooter()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension YYCompetitionViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYCompetitionCell.identifier) as! YYCompetitionCell
        cell.row = indexPath.row 
        cell.model = self.dataArr[indexPath.row] 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
