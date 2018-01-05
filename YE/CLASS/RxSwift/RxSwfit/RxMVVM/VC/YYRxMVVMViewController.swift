//
//  YYRxMVVMViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices
import NSObject_Rx

class YYRxMVVMViewController: YYXIBBaseViewController {

    private let refreshControl = UIRefreshControl()
    private let viewModel = RepositoryListViewModel(initialLanguage: "Swift")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "RxSwift-MVVM"
        
        viewModel.repositories
            .observeOn(MainScheduler.instance)
            .do(onNext: { [weak self] _ in
                    self?.refreshControl.endRefreshing()
            }).bind(to: tableView.rx.items(cellIdentifier: "RepositoryCell", cellType: RepositoryCell.self)) {
                _, repo, cell in
                cell.model_mvvm = repo
        }.disposed(by: self.rx.disposeBag)
        
        viewModel.title
        .bind(to: navigationView.titleLabel.rx.text)
        .disposed(by: self.rx.disposeBag)
        
        viewModel.showRepository
            .subscribe { [weak self] event in
                self?.openRepository(by: event.element!)
        }.disposed(by: self.rx.disposeBag)
    }
    
    private func openRepository(by url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        navigationController?.pushViewController(safariViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
