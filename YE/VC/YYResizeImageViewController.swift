//
//  YYResizeImageViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/11.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import Moya

class YYResizeImageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YYResizeImageViewCell") as! YYResizeImageViewCell
        if indexPath.row == 0 {
            cell.bigImageView.image = UIImage(named: "cgts.jpg")
        } else {
            cell.bigImageView.image = UIImage(named: "1.jpg")
        }
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

}

class YYResizeImageViewCell: UITableViewCell {
    
    @IBOutlet weak var bigImageView: UIImageView!
    
}
