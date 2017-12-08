//
//  YYRxMVCViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import SafariServices // SFSafariViewController

class YYRxMVCViewController: YYXIBBaseViewController {
    
    private enum SegueType: String {
        case languageList = "Show Language List"
    }
    // 刷新控件
    private let refreshControl = UIRefreshControl()
    // 请求对象
    private let githubService = GithubService()
    // 当前界面列表显示哪个语言内容 默认Swift
    fileprivate var currentLanguage = BehaviorSubject(value: "php")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "Rx-MVC"
        
        registerNibWithIdentifier("RepositoryCell")
        tableView.insertSubview(refreshControl, at: 0)
        
        initBinds()
        
        refreshControl.sendActions(for: .valueChanged)
    }
    
    func initBinds() {
        // 刷新控件绑定事件
        let reload = refreshControl.rx.controlEvent(.valueChanged).asObservable()
        
        // 网络请求
        // combineLatest startWith debug flatMap observeOn catchError do
        let repositories = Observable.combineLatest(reload.startWith().debug(), currentLanguage.debug()) { _, language  in
            return language
            }.debug()
            .flatMap {
                [unowned self] in
                self.githubService.getMostPopularRepositories(byLanguage: $0)
                    .observeOn(MainScheduler.instance)
                    .catchError({ error in
                        self.presentAlert(message: error as! String)
                        return .empty()
                    })
            }.do(onNext: { [weak self] _ in
                self?.refreshControl.endRefreshing()
            })
        
        // 数据绑定tableView
        repositories.bind(to: tableView.rx.items(cellIdentifier: "RepositoryCell", cellType: RepositoryCell.self)) { _, repo, cell in
            cell.model = repo
            }.disposed(by: self.rx.disposeBag)
        
        // currentLanguage绑定navigationView title
        currentLanguage
            .bind(to: navigationView.titleLabel.rx.text)
            .disposed(by: self.rx.disposeBag)
        
        // cell点击事件
        tableView.rx.modelSelected(Repository.self).subscribe {
            [weak self] model in
            let vc = SFSafariViewController(url: (model.element?.url.ga_url)!)
            self?.push(vc)
            }.disposed(by: self.rx.disposeBag)
    }
    
    private func presentAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

