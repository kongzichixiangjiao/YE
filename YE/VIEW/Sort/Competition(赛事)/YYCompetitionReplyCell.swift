//
//  YYCompetitionReplyCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionReplyCell: UITableViewCell {

    static let identifier: String = "YYCompetitionReplyCell"
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var myRow: Int!
    
    var reply: YYCompetitionReplyModel! {
        didSet {
            let str = reply.from + "回复" + reply.to + ":" + reply.content
            
            let attStr = NSMutableAttributedString.init(string: str)
            
            attStr.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: 12), range: NSMakeRange(0, str.characters.count))
            
            attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSMakeRange(0, reply.from.characters.count))
            attStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSMakeRange(reply.from.characters.count + 2, reply.to.characters.count))
            
            self.contentLabel.attributedText = attStr
            
            self.contentLabel.yy_addAttributeTapAction(row: self.myRow, [reply.from, reply.to]) { (row, string, range, int) in
                print("点击了\(string)标签 - {\(range.location) , \(range.length)} - \(int)")
            }
            self.dateLabel.text = reply.date
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
