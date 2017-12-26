//
//  YYADViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYADViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var waterBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var waterView: YYWaterView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.emptyDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let storyboard = UIStoryboard(name: "MainRoot", bundle: nil)
//        let rootVC = storyboard.instantiateViewController(withIdentifier: YYTabBarController.identifier)
        let rootVC = storyboard.instantiateInitialViewController()
        
        UIView.animate(withDuration: 0.45, animations: {
            self.waterBottomLayout.constant = -400
            self.waterView.layoutIfNeeded()
            self.view.layoutIfNeeded()
            self.titleLabel.alpha = 1
        }) { (bo) in
            UIApplication.shared.keyWindow?.rootViewController = rootVC
        }
        
        self.tableView.yy_reloadData()
    }

    deinit {
        print("YYADViewController deinit")
    }
}
