//
//  YYBaseTableViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

// 距离安全区域bottom距离
enum SaveAreaBottomSpaceType: CGFloat {
    case normal0 = 0
    case normal44 = 44
}

public let SearchBarViewHeight: CGFloat = 44

class YYBaseTableViewController: YYBaseViewController {
    
    open var dataSource: [Any] = []
    
    open var isShowTabbar: Bool = false
    
    open var isCancleX: Bool = false
    
    open var showSearchBar: Bool = false {
        didSet {
            if showSearchBar {
                self.view.addSubview(searchBarView)
            }
        }
    }
    
    open var saveAreaBottomSpaceType: SaveAreaBottomSpaceType! {
        didSet {
            let y: CGFloat = (isShowNavigationView ? self.navigationView.frame.size.height : 0) + kNavigationViewBottomSpace
            var insets = UIEdgeInsets.zero
            let height = MainScreenHeight - y - (self.isShowTabbar ? TabBarHeight : 0)
            if UIDevice.current.isX {
                if #available(iOS 11.0, *) {
                    insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
                }
            }
            self.tableView.frame = CGRect(x: 0, y: y + (self.isCancleX ? 0 : insets.bottom), width: MainScreenWidth, height: height)
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
        t.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(t)
        return t
    }()
    
    lazy var searchBarView: UIView = {
        let w: CGFloat = self.view.frame.size.width
        let lSpace: CGFloat = 15
        let tSpace: CGFloat = 10
        let v = UIView()
        v.frame = CGRect(x: 0, y: kNavigationBarMaxY, width: w, height: SearchBarViewHeight)
        
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
    
    fileprivate func initFooterView() -> YYBaseTableViewFooterView{
        let footerView = Bundle.main.loadNibNamed("YYBaseTableViewFooterView", owner: self, options: nil)?.last as! YYBaseTableViewFooterView
        return footerView
    }
    
    open func footerView() {
        //        self.tableView.tableFooterView = initFooterView()
    }
    
    open func registerClassWithIdentifier(_ identifier: String) {
        tableView.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
    }
    
    open func registerNibWithIdentifier(_ identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initTableView() {
        
    }
    
    //    func textFieldShouldReturn(_ text: String) {
    //
    //    }
    
    func myTextFieldShouldReturn(_ text: String) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension YYBaseTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        myTextFieldShouldReturn(textField.text!)
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

extension YYBaseTableViewController {
    
}

