//
//  RxSwiftNewsModel.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/30.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import Foundation
import HandyJSON

struct YYRxSwiftNewsModel: HandyJSON {
    var date: String!
    var stories: [YYRxSwiftNewsListModel]?
}

struct YYRxSwiftNewsListModel: HandyJSON {
    var ga_prefix: String!
    var id: String!
    var images: [String]!
    var title: String!
    var type: Int!
}

