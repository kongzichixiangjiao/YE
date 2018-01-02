//
//  YYAlertRootViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum YYAlertCellType: String {
    case normal = "Nomal"
    case text = "Text"
}

class YYAlertRootViewController: UITableViewController {
    
    var dataSource: [YYAlertCellType] = [.normal, .text]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "YYAlertRootCell", bundle: nil), forCellReuseIdentifier: "YYAlertRootCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YYAlertRootCell")
        cell?.textLabel?.text = dataSource[indexPath.row].rawValue
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = dataSource[indexPath.row]
        switch type {
        case .normal:
            let d = YYPresentationDelegate(animationType: .sheet)
            let vc = AnimationBaseViewController(nibName: "AnimationBaseViewController", bundle: nil, delegate: d)
            vc.clickedHandler = {
                tag in
                print(tag)
            }
            self.present(vc, animated: true, completion: nil)
            break
        case .text:
            let d = YYPresentationDelegate(animationType: .middle)
            let vc = YYTextAlertViewController(nibName: "YYTextAlertViewController", bundle: nil, delegate: d)
            vc.duration = 2.0
            self.present(vc, animated: true, completion: nil)
            break
        }
    }
    
}

