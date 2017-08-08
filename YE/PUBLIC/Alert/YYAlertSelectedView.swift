//
//  YYAlertSelectedView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

typealias DidSelectedHandler = (_: Int, _ obj: Any?) -> ()

// MARK: selected
protocol SelectedProtocol {
    var tableView: UITableView { set get }
    var didSelectedHandler: DidSelectedHandler? { set get }
    var selectedData: [Any]? { set get }
    var headerView: YYAlertSelectedTableViewHeaderView { set get }
}

extension UIView: SelectedProtocol {
    var headerView: YYAlertSelectedTableViewHeaderView {
        get {
            guard let h: YYAlertSelectedTableViewHeaderView = objc_getAssociatedObject(self, &YYAlertKey.kSelectedHeaderView) as? YYAlertSelectedTableViewHeaderView else {
                let headerView = Bundle.main.loadNibNamed("YYAlertSelectedTableViewHeaderView", owner: self, options: nil)?.last as! YYAlertSelectedTableViewHeaderView
                headerView.showLineView(space: 0)
                headerView.clipStaticViewRectCorner(.topLeft, cornerRadius: 5)
                headerView.closed.addTarget(self, action: #selector(closedAction), for: .touchUpInside)
                objc_setAssociatedObject(self, &YYAlertKey.kSelectedHeaderView, headerView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return headerView
            }
            return h
        }
        set {
            
        }
    }

    var selectedData: [Any]? {
        get {
            guard let d: [Any] = objc_getAssociatedObject(self, &YYAlertKey.kSelectedData) as? [Any] else {
                
                return nil
            }
            return d
        }
        set {
            
        }
    }
    
    var didSelectedHandler: DidSelectedHandler? {
        get {
            guard let handler: DidSelectedHandler = objc_getAssociatedObject(self, &YYAlertKey.kDidSelectedHandler) as? DidSelectedHandler else {
                
                return nil
            }
            return handler
        }
        set {
            
        }
    }
    
    var tableView: UITableView {
        get {
            guard let tableView: UITableView = objc_getAssociatedObject(self, &YYAlertKey.kTableView) as? UITableView else {
                let t = UITableView()
                t.frame = CGRect(x: 0, y: 0, width: self.alertWindow.bounds.size.width * 0.5, height: self.selectedData!.count.cgFloat * kYYAlertSelectedCellHeight)
                t.delegate = self
                t.dataSource = self
                t.isUserInteractionEnabled = true
                t.showsHorizontalScrollIndicator = false
                t.showsVerticalScrollIndicator = false
                t.separatorStyle = .none
                t.tableFooterView = UIView()
                
                t.clipStaticViewRectCorner(.bottomRight, cornerRadius: 10)
                
                t.register(UINib(nibName: kYYAlertSelectedCell, bundle: nil), forCellReuseIdentifier: kYYAlertSelectedCell)
                
                objc_setAssociatedObject(self, &YYAlertKey.kTableView, t, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return t
            }
            return tableView
        }
        set {
            
        }
    }
    
    func closedAction() {
        ga_dissmissBlackWindow()
    }
    
    func showSelectedLoading(title: String = "请选择", data: [Any], _ handler: @escaping DidSelectedHandler) {
        self.selectedData = data
        objc_setAssociatedObject(self, &YYAlertKey.kSelectedData, data, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.alertWindow.gestureRecognizers?.removeAll()
        self.tableView.frame = CGRect(x: 0, y: 0, width: self.alertWindow.bounds.size.width * 0.5, height: self.selectedData!.count.cgFloat * kYYAlertSelectedCellHeight)
        self.tableView.center = self.alertWindow.center
        
        self.alertWindow.addSubview(self.tableView)
        
        self.alertWindow.addSubview(self.headerView)
        self.headerView.myTitle = title
        self.headerView.frame = CGRect(x: self.tableView.x, y: self.tableView.y - kYYAlertSelectedTableViewHeaderViewHeight, width: self.alertWindow.bounds.size.width * 0.5, height: kYYAlertSelectedTableViewHeaderViewHeight)
        
        self.didSelectedHandler = handler
        objc_setAssociatedObject(self, &YYAlertKey.kDidSelectedHandler, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func hideSelectedLoading() {
        guard let tableView: UITableView = objc_getAssociatedObject(self, &YYAlertKey.kTableView)
            as? UITableView else {
                return
        }
        tableView.removeFromSuperview()
        objc_setAssociatedObject(self, &YYAlertKey.kTableView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &YYAlertKey.kDidSelectedHandler, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &YYAlertKey.kSelectedData, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        objc_setAssociatedObject(self, &YYAlertKey.kSelectedHeaderView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

extension UIView: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let d = self.selectedData else {
            return 0
        }
        return d.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kYYAlertSelectedCellHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYAlertSelectedCell = tableView.dequeueReusableCell(withIdentifier: kYYAlertSelectedCell) as! YYAlertSelectedCell
        cell.myTitle = self.selectedData?[indexPath.row] as? String
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectedHandler?(indexPath.row, nil)
        ga_dissmissBlackWindow()
        tableView.deselectRow(at: indexPath, animated: true);
    }
}
