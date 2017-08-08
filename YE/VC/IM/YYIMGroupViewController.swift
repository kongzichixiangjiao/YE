//
//  YYIMGroupViewController.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/7/25.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYIMGroupViewController: YYIMBaseMessageViewController {

    var group: EMGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imTitle = "群"
        self.navigationView.setupRightButton(type: .details)
    }
    
    override func clickedRightButtonAction(sender: UIButton) {
        super.clickedRightButtonAction(sender: sender)
        let vc = YYIMGroupInfoViewController()
        vc.group = self.group
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
