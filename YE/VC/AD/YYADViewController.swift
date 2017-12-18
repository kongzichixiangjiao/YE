//
//  YYADViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYADViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var waterBottomLayout: NSLayoutConstraint!
    @IBOutlet weak var waterView: YYWaterView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(withIdentifier: YYTabBarController.identifier)
    
        UIView.animate(withDuration: 1, animations: {
            self.waterBottomLayout.constant = -400
            self.waterView.layoutIfNeeded()
            self.view.layoutIfNeeded()
            self.titleLabel.alpha = 1
        }) { (bo) in
            UIApplication.shared.keyWindow?.rootViewController = rootVC
        }
    }

    deinit {
        print("YYADViewController deinit")
    }

}
