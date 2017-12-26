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
        
        
    }

    deinit {
        print("YYADViewController deinit")
    }
}

extension YYADViewController: UITableViewDelegate, UITableViewDataSource, UITableViewPlaceHolderDelegate {
    func tableViewPlaceHolderView() -> UIView {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        v.backgroundColor = UIColor.orange
        return v
    }
    
    func tableViewEnableScrollWhenPlaceHolderViewShowing() -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

