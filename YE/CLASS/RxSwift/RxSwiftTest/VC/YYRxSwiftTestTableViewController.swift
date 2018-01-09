//
//  YYRxSwiftTestTableViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Moya
import RxSwift
import RxCocoa
import RxDataSources

class YYRxSwiftTestTableViewController: YYXIBBaseViewController {
    
    let disposeBag = DisposeBag()
    
    var dataArr = Variable([YYRxSwiftNewsListModel]())
    
    let items = Observable.just([
        SectionModel(model: "First", items:[
            1.0,
            2.0,
            3.0
            ]),
        SectionModel(model: "Second", items:[
            1.0,
            2.0,
            3.0
            ]),
        SectionModel(model: "Third", items:[
            1.0,
            2.0,
            3.0
            ])
        ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "Rx-TableView"
        
        tableView.register(UINib(nibName: YYRxSwiftViewCell.identifier, bundle: nil), forCellReuseIdentifier: YYRxSwiftViewCell.identifier)
        
        self.tableView.ga_addRefreshHeaderXIB(GA_AnimationRefreshHeaderView.loadView()) {
            [weak self] in
            if let weakSelf = self {
                weakSelf.requestData()
            }
        }
        
        //        rx_tableView_0()
        //        rx_tableView_1()
        rx_tableView_2()
    }
    
    func rx_tableView_2() {
        requestData()
        
        self.dataArr
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: YYRxSwiftViewCell.identifier, cellType: YYRxSwiftViewCell.self)) {
                (row, model, cell) in
                print(model.id)
                cell.titleLabel.text = model.id + "-" + model.title
            }
            .disposed(by: disposeBag)
    }
    
    func requestData() {
        YYRequest.share.provider.request(.getNewsList) { (result) in
            switch result {
            case .success:
//                self.dataArr.value += result.value?.mapModel(YYRxSwiftNewsModel.self).stories ?? []
                break
            case .failure:
                print(result.error ?? "--")
                break
            }
            
            self.tableView.ga_XIBendRefreshing()
        }
    }
    
    func rx_tableView_1() {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(configureCell: {
            dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: YYRxSwiftViewCell.identifier) as! YYRxSwiftViewCell
            cell.titleLabel.text = "\(indexPath.row)"
            return cell
        })
        
        dataSource.titleForHeaderInSection = {
            dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx
            .setDelegate(self as UITableViewDelegate)
            .disposed(by: disposeBag)
        
    }
    
    func rx_tableView_0() {
        let items = Observable.just(
            (0...20).map{ "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: YYRxSwiftViewCell.identifier, cellType: YYRxSwiftViewCell.self)){
                (row, elememt, cell) in
                cell.titleLabel.text = "\(elememt)"
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(
                onNext:{
                    value in
                    if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                        self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                    }
                    print("click \(value)")
            })
            .disposed(by: disposeBag)
    }
}

extension YYRxSwiftTestTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let v = UILabel()
    //        v.frame = CGRect(x: 0, y: 0, width: tableView.width, height: 44)
    //        v.backgroundColor = UIColor.orange
    //        return v
    //    }
}

