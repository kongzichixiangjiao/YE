//
//  YYCompetitionViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionViewController: YYBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationView()
        initTableView()
    }
    
    func initNavigationView() {
        self.myTitle = "赛事"
        self.isHiddenLeftButton = true
    }
    
    override func initTableView() {
        saveAreaBottomSpaceType = .normal44
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        registerNibWithIdentifier(YYCompetitionCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension YYCompetitionViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYCompetitionCell.identifier) as! YYCompetitionCell
        if (indexPath.row == 0) {
            cell.titleLabel.text = "树影下的人想睡"
            cell.describeLabel.text = "清澈倒映在河水的中央"
        } else if (indexPath.row == 1) {
            cell.titleLabel.text = "繁闹市停留 留下雨和愁 人路过只有我静候"
            cell.describeLabel.text = "繁闹市停留 留下雨和愁 人路过只有我静候 繁闹市停留 留下雨和愁 人路过只有我静候 繁闹市停留 留下雨和愁 人路过只有我静候"
        } else if (indexPath.row == 2) {
            cell.titleLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年"
            cell.describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年 乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年"
        } else {
            cell.titleLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年"
            cell.describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年 乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
