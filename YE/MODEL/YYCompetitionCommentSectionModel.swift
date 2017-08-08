//
//  YYCompetitionCommentSectionModel.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import UIKit

struct YYCompetitionCommentSectionModel {
    let width: CGFloat = MainScreenWidth - 135
    let defaultHeight: CGFloat = 55
    let fontSize: CGFloat = 12
    
    let replyDefaultHeight: CGFloat = 44
    
    var headerUrl: String!
    var title: String!
    var content: String!
    var reply: [YYCompetitionReplyModel]!
    var likeNumber: Int!
    var isLike: Bool!
    var height: CGFloat!
    var replyHeight: CGFloat = 0
    
    init(dic: [String : Any]) {
        self.headerUrl = dic["headerUrl"] as? String ?? ""
        self.title = dic["title"] as? String ?? ""
        self.likeNumber = dic["likeNumber"] as? Int ?? 0
        self.isLike = dic["isLike"] as? Bool ?? false
        self.reply = YYCompetitionReplyModel.getModels(arr: dic["reply"] as? [[String : String]] ?? [["":""]])
        self.content = dic["content"] as? String ?? ""
        self.height = self.content.ga_heightWith(fontSize: fontSize, width: width, style: NSAttributedString.yy_paragraphStyle()) + defaultHeight
        
        self.replyHeight = replyDefaultHeight
        for (_,value) in self.reply.enumerated() {
            self.replyHeight += value.height
        }
    }
    
    static func getModels(arr: [[String : Any]]) -> [YYCompetitionCommentSectionModel] {
        var models: [YYCompetitionCommentSectionModel] = []
        for dic in arr {
            let model = YYCompetitionCommentSectionModel(dic: dic)
            models.append(model)
        }
        return models
    }
}

struct YYCompetitionReplyModel {
    let width: CGFloat = MainScreenWidth - 65
    let defaultHeight: CGFloat = 42
    let fontSize: CGFloat = 12
    
    var from: String!
    var to: String!
    var content: String!
    var height: CGFloat!
    var date: String!
    
    init(dic: [String : Any]) {
        self.from = dic["from"] as? String ?? ""
        self.to = dic["to"] as? String ?? ""
        self.content = dic["content"] as? String ?? ""
        self.height = (self.from + "回复" + self.to + ":" + self.content).ga_heightWith(fontSize: fontSize, width: width) + defaultHeight
        self.date = dic["date"] as? String ?? ""
    }
    static func getModels(arr: [[String : Any]]) -> [YYCompetitionReplyModel] {
        var models: [YYCompetitionReplyModel] = []
        for dic in arr {
            let model = YYCompetitionReplyModel(dic: dic)
            models.append(model)
        }
        return models
    }
}
