//
//  YYDrawerTableViewCell_EG.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//
import UIKit
import YYDrawerTableViewCell

class YYDrawerTableViewCellNew: YYDrawerTableViewCell {
    
    static let identifier1 = "YYDrawerTableViewCellNew"
    
    open override class func custom(_ tableView: UITableView, handler: @escaping ScrollDidselectedHandler, clickedHandler:
        @escaping ClickedHandler) -> YYDrawerTableViewCellNew {
        var cell = tableView.dequeueReusableCell(withIdentifier: YYDrawerTableViewCellNew.identifier1)
        if cell == nil {
            cell = YYDrawerTableViewCellNew(identifier: YYDrawerTableViewCellNew.identifier1, titles: ["删除", "赞", "扯淡", "吃饭"], handler: handler, clickedHandler: clickedHandler)
        }
        return cell! as! YYDrawerTableViewCellNew
    }
    
    override func initUI(_ titles: [String]) {
        super.initUI(titles)
        let v = UIView()
        v.frame = CGRect(x: 10, y: 10, width: 10, height: 100);
        v.backgroundColor = UIColor.orange
        self.myContentView.addSubview(v)
        
    }
}
