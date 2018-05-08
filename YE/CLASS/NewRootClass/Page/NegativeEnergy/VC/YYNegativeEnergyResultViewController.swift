//
//  YYNegativeEnergyResultViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/7.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYNegativeEnergyResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var resultText: String! {
        didSet {
            print(resultText)
            dataList.append(resultText)
            tableView.reloadData()
        }
    }
    
    var dataList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: YYNegativeEnergyAdvanceCell.identifier, bundle: nil), forCellReuseIdentifier: YYNegativeEnergyAdvanceCell.identifier)
        self.tableView.register(UINib(nibName: YYNegativeEnergyResultCell.identifier, bundle: nil), forCellReuseIdentifier: YYNegativeEnergyResultCell.identifier)
        
        print(self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension YYNegativeEnergyResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (self.dataList.count > 0) {
            tableView.separatorStyle = .singleLine
            let cell = tableView.dequeueReusableCell(withIdentifier: YYNegativeEnergyResultCell.identifier) as! YYNegativeEnergyResultCell
            cell.describeLabel.text = dataList[indexPath.row]
            return cell
        } else {
            tableView.separatorStyle = .none
            let cell = tableView.dequeueReusableCell(withIdentifier: YYNegativeEnergyAdvanceCell.identifier) as! YYNegativeEnergyAdvanceCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.dataList.count > 0) {
            return self.dataList.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.dataList.count > 0) {
            return 44
        } else {
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(YYNegativeEnergyDetailsViewController(), animated: true)
    }
}
