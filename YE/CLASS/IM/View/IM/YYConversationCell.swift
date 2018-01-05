//
//  YYConversationCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/12.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import EaseUILite

class YYConversationCell: UITableViewCell {
    
    static let identifier: String = "YYConversationCell"
    
    @IBOutlet weak var conversactionIdLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var unreadMessagesCountLabel: UILabel!
    @IBOutlet weak var latestMessageLabel: UILabel!
    
    var conversation: EMConversation! {
        didSet {
            conversactionIdLabel.text = conversation.conversationId
            typeLabel.text = String(describing: conversation.type)
            unreadMessagesCountLabel.text = String(conversation.unreadMessagesCount)
//            latestMessageLabel.text = conversation.latestMessage.description
            print(conversation.latestMessage)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
