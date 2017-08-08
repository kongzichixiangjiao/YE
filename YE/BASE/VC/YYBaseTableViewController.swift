//
//  YYBaseTableViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum TableViewFrameType: CGFloat {
    case normal0 = 0
    case normal20 = 20
    case normal64 = 64
    case normal108 = 108
}

public var MainScreenWidth = UIScreen.main.bounds.width
public var MainScreenHeight = UIScreen.main.bounds.height
public let SearchBarViewHeight: CGFloat = 44

class YYBaseTableViewController: YYBaseViewController {

    public var dataSource: [Any] = []
    
    public var isShowTabbar: Bool = false
    
    public var showSearchBar: Bool = false {
        didSet {
            if showSearchBar {
                self.view.addSubview(searchBarView)
            }
        }
    }
    
    public var tableViewFrameType: TableViewFrameType! {
        didSet {
            let y: CGFloat = tableViewFrameType.rawValue
            self.tableView.frame = CGRect(x: 0, y: y, width: MainScreenWidth, height: MainScreenHeight - y - (self.isShowTabbar ? TabBarHeight : 0))
        }
    }
    
    lazy var tableView: UITableView = {
        let t = UITableView(frame: CGRect.zero)
        t.delegate = self
        t.dataSource = self
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none 
        t.tableFooterView = UIView()
        self.view.addSubview(t)
        return t
    }()
    
    lazy var searchBarView: UIView = {
        let w: CGFloat = self.view.frame.size.width
        let lSpace: CGFloat = 15
        let tSpace: CGFloat = 10
        let v = UIView()
        v.frame = CGRect(x: 0, y: NavigationViewHeight, width: w, height: SearchBarViewHeight)
        
        let t = UITextField(frame: CGRect(x: lSpace, y: tSpace, width: w - lSpace * 2, height: SearchBarViewHeight - tSpace * 2))
        t.font = UIFont.systemFont(ofSize: 13)
        t.placeholder = "输入对方昵称..."
        t.delegate = self
        v.addSubview(t)
        
        let l = UIView()
        l.frame = CGRect(x: 0, y: SearchBarViewHeight - 1.0 / UIScreen.main.scale, width: w, height: 1.0 / UIScreen.main.scale)
        l.backgroundColor = "e4e1e1".color0X
        v.addSubview(l)
        return v
    }()
    
    private func initFooterView() -> YYBaseTableViewFooterView{
        let footerView = Bundle.main.loadNibNamed("YYBaseTableViewFooterView", owner: self, options: nil)?.last as! YYBaseTableViewFooterView
        return footerView
    }
    
    public func footerView() {
//        self.tableView.tableFooterView = initFooterView()
    }
    
    public func registerClassWithIdentifier(_ identifier: String) {
        tableView.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
    }
    
    public func registerNibWithIdentifier(_ identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()

    }
    
    func initTableView() {
        
    }
    
    func textFieldShouldReturn(text: String) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYBaseTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textFieldShouldReturn(text: textField.text!)
        return true
    }
}

extension YYBaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
}
