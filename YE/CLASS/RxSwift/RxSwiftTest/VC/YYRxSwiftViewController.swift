//
//  YYRxSwiftViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum rxType: String {
    case of = "of", generate = "generate", error = "error", deferred = "deferred", empty = "empty", never = "never", just = "just", publishSubject = "publishSubject", replaySubject = "replaySubject", behaviorSubject = "behaviorSubject", variable = "variable", map = "map", flatMap = "flatMap", scan = "scan", distinctUntilChanged = "distinctUntilChanged", take = "take", startWith = "startWith", combineLatest = "combineLatest", zip = "zip", merge = "merge", switchLatest = "switchLatest", catchError = "catchError", retry = "retry", subscribe = "subscribe", subscribeNext = "subscribeNext", subscribeCompleted = "SubscribeCompleted", subscribeError = "subscribeError", doOn = "doOn", takeUntil = "takeUntil", takeWhile = "takeWhile", concat = "concat", reduce = "reduce", delay = "delay"
}

class YYRxSwiftViewController: YYXIBBaseViewController {

    var dataSource: [rxType] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "RxSwift"
        self.setupRightButton(.add)
        
        dataSource = [.of, .generate, .error, .deferred, .empty, .never, .just, .publishSubject, .replaySubject, .behaviorSubject, .variable, .map, .flatMap, .scan, .distinctUntilChanged, .take, .startWith, .combineLatest, .zip, .merge, .switchLatest, .catchError, .retry, .subscribe, .subscribeNext, .subscribeCompleted, .subscribeError, .doOn, .takeUntil, .takeWhile, .concat, .reduce, .delay]
        
        tableView.register(UINib(nibName: YYRxSwiftViewCell.identifier, bundle: nil), forCellReuseIdentifier: YYRxSwiftViewCell.identifier)
    }
    
    override func clickedRightButtonAction(_ sender: UIButton) {
        push(YYRxSwiftPlusViewController(nibName: "YYRxSwiftPlusViewController", bundle: nil))
    }
    
    @IBAction func pushRxSwiftTestVC(_ sender: UIButton) {
        push(YYRxSwiftTestTableViewController(nibName: "YYRxSwiftTestTableViewController", bundle: nil))
    }
    
    @IBAction func pushRxMVCVC(_ sender: UIButton) {
        push(YYRxMVCViewController(nibName: "YYRxMVCViewController", bundle: nil))
    }
    
    @IBAction func pushRxMVVMVC(_ sender: Any) {
        push(YYRxMVVMViewController(nibName: "YYRxMVVMViewController", bundle: nil))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYRxSwiftViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 44
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYRxSwiftViewCell.identifier) as! YYRxSwiftViewCell
        cell.titleLabel.text = dataSource[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = YYRxSwiftTestViewController()
        let type = dataSource[indexPath.row]
        vc.type = type
        push(vc)
    }
}
