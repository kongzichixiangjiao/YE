//
//  YYApplyModel.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation

enum YYApplyCellType: Int {
    case text = 1, selected = 2, image = 3, picker = 4
}

struct YYApplyModel {
    var key: String!
    var must: Bool!
    var placeholder: String?
    var type: Int!
    var value: String!
    var data: [String]?
    var imageData: [Data]?
    
    init(dic: [String: Any]) {
        self.key = dic["key"] as? String ?? "--"
        self.must = dic["must"] as? Bool ?? true
        self.placeholder = dic["placeholder"] as? String ?? "--"
        self.type = dic["type"] as? Int ?? -1
        self.value = dic["value"] as? String ?? "--"
        self.data = dic["data"] as? [String] ?? []
        self.imageData = dic["imageData"] as? [Data] ?? []
    }
}
