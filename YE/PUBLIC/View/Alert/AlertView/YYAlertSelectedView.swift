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
    var ga_tableView: UITableView { set get }
    var ga_didSelectedHandler: DidSelectedHandler? { set get }
    var ga_selectedData: [Any]? { set get }
    var ga_headerView: YYAlertSelectedTableViewHeaderView { set get }
}

extension UIView: SelectedProtocol {
    var ga_headerView: YYAlertSelectedTableViewHeaderView {
        get {
            guard let h: YYAlertSelectedTableViewHeaderView = objc_getAssociatedObject(self, &YYAlertKey.kSelectedHeaderView) as? YYAlertSelectedTableViewHeaderView else {
                let headerView = Bundle.main.loadNibNamed("YYAlertSelectedTableViewHeaderView", owner: self, options: nil)?.last as! YYAlertSelectedTableViewHeaderView
                headerView.showLineView(0)
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

    var ga_selectedData: [Any]? {
        get {
            guard let d: [Any] = objc_getAssociatedObject(self, &YYAlertKey.kSelectedData) as? [Any] else {
                
                return nil
            }
            return d
        }
        set {
            
        }
    }
    
    var ga_didSelectedHandler: DidSelectedHandler? {
        get {
            guard let handler: DidSelectedHandler = objc_getAssociatedObject(self, &YYAlertKey.kDidSelectedHandler) as? DidSelectedHandler else {
                
                return nil
            }
            return handler
        }
        set {
            
        }
    }
    
    var ga_tableView: UITableView {
        get {
            guard let tableView: UITableView = objc_getAssociatedObject(self, &YYAlertKey.kTableView) as? UITableView else {
                let t = UITableView()
                t.frame = CGRect(x: 0, y: 0, width: self.alertWindow.bounds.size.width * 0.5, height: self.ga_selectedData!.count.cgFloat * kYYAlertSelectedCellHeight)
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
    
    @objc func closedAction() {
        ga_dissmissBlackWindow()
    }
    
    func showSelectedLoading(_ title: String = "请选择", data: [Any], _ handler: @escaping DidSelectedHandler) {
        self.ga_selectedData = data
        objc_setAssociatedObject(self, &YYAlertKey.kSelectedData, data, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        self.alertWindow.gestureRecognizers?.removeAll()
        self.ga_tableView.frame = CGRect(x: 0, y: 0, width: self.alertWindow.bounds.size.width * 0.5, height: self.ga_selectedData!.count.cgFloat * kYYAlertSelectedCellHeight)
        self.ga_tableView.center = self.alertWindow.center
        
        self.alertWindow.addSubview(self.ga_tableView)
        
        self.alertWindow.addSubview(self.ga_headerView)
        self.ga_headerView.myTitle = title
        self.ga_headerView.frame = CGRect(x: self.ga_tableView.x, y: self.ga_tableView.y - kYYAlertSelectedTableViewHeaderViewHeight, width: self.alertWindow.bounds.size.width * 0.5, height: kYYAlertSelectedTableViewHeaderViewHeight)
        
        self.ga_didSelectedHandler = handler
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
        guard let d = self.ga_selectedData else {
            return 0
        }
        return d.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kYYAlertSelectedCellHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYAlertSelectedCell = tableView.dequeueReusableCell(withIdentifier: kYYAlertSelectedCell) as! YYAlertSelectedCell
        cell.myTitle = self.ga_selectedData?[indexPath.row] as? String
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.ga_didSelectedHandler?(indexPath.row, nil)
        ga_dissmissBlackWindow()
        tableView.deselectRow(at: indexPath, animated: true);
    }
}
