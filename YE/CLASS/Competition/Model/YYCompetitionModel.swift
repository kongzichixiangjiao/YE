//
//  YYCompetitionModel.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON

struct YYPXModel: HandyJSON {
    var hotspot: [YYPXHotSpot]?
}

struct YYPXHotSpot: HandyJSON {
    var conferenceTime: String!
    var content: String!
    var id: String!
    var imgUrl: String!
    var introduction: String!
    var label: String!
    var period: String!
    var redirectUrl: String!
    var thumbsUpNum: String!
    var title: String!
    var titleDetail: String!
    var titleImg: String!
}
