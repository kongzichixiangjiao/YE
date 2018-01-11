//
//  Sample.swift
//  YE
//
//  Created by 侯佳男 on 2018/1/9.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit
import WCDBSwift

/*
class Sample {
    var identifier: Int? = nil
    var description: String? = nil
}
*/

class Sample: TableCodable {
    var identifier: Int? = nil
    var description: String? = nil
    var offset: Int = 0
    var debugDescription: String? = nil  // 不需要写入表 枚举内可不添加
    
    var multiIndexPart1: Int = 0
    var multiIndexPart2: Int = 0
 
    /*
    var multiPrimaryKeyPart1: Int = 0
    var multiPrimaryKeyPart2: Int = 0
    var multiUniquePart1: Int = 0
    var multiUniquePart2: Int = 0
    */
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier = "id" // 别名映射
        case description
        case offset = "db_offset" // 变量名与 SQLite 的保留关键字冲突的字段,offset 是 SQLite 的关键字。
        
        case multiIndexPart1
        case multiIndexPart2
 
        /*
        case multiPrimaryKeyPart1
        case multiPrimaryKeyPart2
        case multiUniquePart1
        case multiUniquePart2
        */
        // 约束
        static var columnConstraintBindings: [CodingKeys : ColumnConstraintBinding]? {
            return [
                identifier: ColumnConstraintBinding(isPrimary: true),
                description: ColumnConstraintBinding(isNotNull: true, defaultTo: "defaultDescription")
            ]
        }
        
        // 索引
        static var indexBindings: [IndexBinding.Subfix : IndexBinding]? {
            return [
                "_uniqueIndex" : IndexBinding(isUnique: true, indexesBy: identifier),
                "_descendingIndex" : IndexBinding(indexesBy: description.asIndex(orderBy: .descending)),
                "_multiIndex" : IndexBinding(indexesBy: multiIndexPart1, multiIndexPart2.asIndex(orderBy: .ascending))
            ]
        }
 
        /*
        // 表约束
        static var tableConstraintBindings: [TableConstraintBinding.Name : TableConstraintBinding]? {
            let multiPrimaryBinding = MultiPrimaryBinding(indexesBy: multiPrimaryKeyPart1.asIndex(orderBy: .descending), multiPrimaryKeyPart2)
            let multiUniqueBinding = MultiUniqueBinding(indexesBy: multiUniquePart1, multiUniquePart2.asIndex(orderBy: .ascending))
            return [
                "MultiPrimaryConstraint" : multiPrimaryBinding, // 联合主键约束
                "MultiUniqueConstraint" : multiUniqueBinding // 联合唯一约束
            ]
        }
        */
    }
    var isAutoIncrement: Bool = false // 用于定义是否使用自增的方式插入
    // 自增属性
    var lastInsertedRowID: Int64 = 0 // 用于获取自增插入后的主键值
}

/*
 ColumnConstraintBinding (
     isPrimary: Bool = false, // 该字段是否为主键。字段约束中只能同时存在一个主键
     orderBy term: OrderTerm? = nil, // 当该字段是主键时，存储顺序是升序还是降序
     isAutoIncrement: Bool = false, // 当该字段是主键时，其是否支持自增。只有整型数据可以定义为自增。
     onConflict conflict: Conflict? = nil, // 当该字段是主键时，若产生冲突，应如何处理
     isNotNull: Bool = false, // 该字段是否可以为空
     isUnique: Bool = false, // 该字段是否可以具有唯一性
     defaultTo defaultValue: ColumnDef.DefaultType? = nil // 该字段在数据库内使用什么默认值
 )
 */

/*
 表约束通过约束名到表约束的映射实现。包含：
 
    1、MultiPrimaryBinding: 联合主键约束
    2、MultiUniqueBinding: 联合唯一约束
    3、CheckBinding: 检查约束
    4、ForeignKeyBinding: 外键约束
 */

/********/
/********/
/*表升级*/
/********/
/********/
/*
 原表
class Sample: TableCodable {
    var identifier: Int? = nil
    var description: String? = nil
    var createDate: Date? = nil
    
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case description
        case createDate
    }
}

try database.create(table: "sampleTable", of: Sample.self)
*/
/*
 升级表
class Sample: TableCodable {
    var identifier: Int? = nil
    var content: String? = nil
    var title: String? = nil // 对于新增的 title 会被添加到表中。
    // var createDate: Date? = nil // 已删除的 createDate 字段会被忽略。
 
    enum CodingKeys: String, CodingTableKey {
        typealias Root = Sample
        static let objectRelationalMapping = TableBinding(CodingKeys.self)
        case identifier
        case content = "description" // description 字段通过别名的特性，被重命名为了 content。
        case title
    }
    static var indexBindings: [IndexBinding.Subfix: IndexBinding]? {
        return [
            "_index": IndexBinding(indexesBy: title)
        ]
    }
}
// 升级的表需要重新create
try database.create(table: "sampleTable", of: Sample.self)
*/
