//
//  YYCompetitionCommentCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCompetitionCommentCell: UITableViewCell {

    static let identifier: String = "YYCompetitionCommentCell"
    
    var model: YYCompetitionCommentSectionModel! {
        didSet {
            titleLabel.text = model.title
        }
    }
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.myTableView.register(UINib(nibName: YYCompetitionReplyCell.identifier, bundle: nil), forCellReuseIdentifier: YYCompetitionReplyCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension YYCompetitionCommentCell {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYCompetitionReplyCell = tableView.dequeueReusableCell(withIdentifier: YYCompetitionReplyCell.identifier) as! YYCompetitionReplyCell
        cell.myRow = indexPath.row
        cell.reply = self.model.reply[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.model.reply[indexPath.row].height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.reply.count
    }
}
