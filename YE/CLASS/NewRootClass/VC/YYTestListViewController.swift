//
//  YYTestListViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/4/25.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

//enum TestListPushType: String {
//    case: jfHome = "YYJFHomeViewController"
//}

enum YYTestListPushType: String {
    case jfHome = "YYJFHomeViewController"
}

class YYTestListViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myTitle = "Test List"
        
        initData()
        
        initTableView()
    }
    
    func initData() {
        let path = Bundle.yy_plistPath(.testList)
        
        let arr = NSArray.init(contentsOf: URL(fileURLWithPath: path))
        let jsonString = arr?.yy_toJSON
        if let list = ([YYTestListModel].deserialize(from: jsonString) as? [YYTestListModel]) {
            self.dataSource = list
        }
    }
    
    override func initTableView() {
        isShowTabbar = true
        saveAreaBottomSpaceType = .normal44
        registerNibCell([YYTestListCell.identifier])
    }
    
    override func clickedLeftButtonAction() {
        guard let nav: YYNavigationViewController = self.parent?.parent?.parent as? YYNavigationViewController else {
            return
        }
        _ = nav.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYTestListViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYTestListCell.identifier, for: indexPath) as! YYTestListCell
        cell.model = self.dataSource[indexPath.row] as! YYTestListModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.dataSource[indexPath.row] as! YYTestListModel
        
        if (model.isNib) {
            self.yy_pushXIB(nibName: model.vcName)
//            let vc = YYSourceTransitionViewController(nibName: model.vcName, bundle: nil)
//            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            switch model.vcName {
                case YYTestListPushType.jfHome.rawValue:
                    self.yy_push(vc: YYJFHomeViewController())
                break
            default:
                break
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
