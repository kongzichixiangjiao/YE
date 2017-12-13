//
//  YYRxSwiftBaseViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/25.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class YYXIBBaseViewController: YYBaseViewController {
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = self.backView {
            self.backView.backgroundColor = UIColor.blue
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupBackViewConstant()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupBackViewConstant() {
        if let _ = self.backView {
            let topConstant: CGFloat = self.navigationView.frame.origin.y + self.navigationView.frame.size.height
            
            for constraint in self.backView.constraints {
                if constraint.firstAttribute == .top {
                    if ((constraint.secondItem as? UIView)!.isEqual(backView)) {
                        constraint.constant = topConstant
                        self.backView.layoutIfNeeded()
                    }
                }
            }
        }
    }
    
    open func registerClassWithIdentifier(_ identifier: String) {
        tableView.register(NSClassFromString(identifier), forCellReuseIdentifier: identifier)
    }
    
    open func registerNibWithIdentifier(_ identifier: String) {
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

