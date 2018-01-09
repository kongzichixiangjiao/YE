//
//  YYCompetitionCell.swift
//  YE
//
//  Created by 侯佳男 on 2017/8/14.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionCell: UITableViewCell {
    
    static let identifier: String = "YYCompetitionCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var describeLabel: UILabel!
    @IBOutlet weak var headImageView: UIImageView!
    
    var row: Int!
    var model: YYPXHotSpot! {
        didSet {
            titleLabel.text = model.title
            describeLabel.text = model.content
            headImageView.kf.setImage(with: model.titleImg.ga_url)
            switch row {
            case 0:
                describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年 乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年"
                break
            case 1:
                describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变"
                break
            case 2:
                describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 "
                break
            case 3:
                describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年 "
                break
            case 4:
                describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年 乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变"
                break
                
            default:
                describeLabel.text = "乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年 乌溜溜的黑眼珠和你的笑脸 怎么也难忘竟容颜的转变 轻飘飘的旧时光就这么溜走 转头回去看看时已匆匆数年"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

