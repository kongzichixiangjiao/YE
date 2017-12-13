//
//  YYResizeImageViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/11.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  图片按照屏幕宽压缩展示在tableView中

import UIKit

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
            cell.bigImageView.yy_setResizeImage(urlString: "cgts.jpg", width: MainScreenWidth)
        } else {
            cell.bigImageView.yy_setResizeImage(urlString: "1.jpg", width: MainScreenWidth)
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
