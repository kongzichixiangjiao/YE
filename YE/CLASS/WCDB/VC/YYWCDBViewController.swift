////
////  YYWCDBViewController.swift
////  YE
////
////  Created by 侯佳男 on 2018/1/9.
////  Copyright © 2018年 侯佳男. All rights reserved.
////
//
//import UIKit
//import WCDBSwift
//
//class YYWCDBViewController: YYBaseViewController {
//
//    private let kSampleTable = "sampleTable"
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.myTitle = "WCDBSwift"
//
//        let database = Database(withPath: String.path(type: .libraryCaches) + "Created/sample.db")
//        // SQL：CREATE TABLE IF NOT EXISTS sampleTable(id INTEGER, description TEXT, db_offset INTEGER)
//        do {
//            try database.create(table: kSampleTable, of: Sample.self)
//        } catch let error {
//            print(error)
//        }
//        
////        try? database.delete(fromTable: kSampleTable, where: Sample.Properties.identifier > 3, limit: 1)
//        
//        for i in 0..<5 {
//            let object = Sample()
//            object.identifier = i
//            object.description = "sample_insert" + String(i)
//            try? database.insert(objects: [object], intoTable: kSampleTable)
//        }
//
//        let objects3: [Sample] = try! database.getObjects(fromTable: kSampleTable)
//        print(objects3.first?.lastInsertedRowID ?? "--")
//
//        let objects: [Sample] = try! database.getObjects(fromTable: kSampleTable)
//        for obj in objects3 {
//            print(obj.identifier ?? "--")
//            print(obj.lastInsertedRowID)
//        }
//        print(objects.first?.identifier ?? "--")
//        print(objects.first?.description ?? "--")
//
//        let object1 = Sample()
//        object1.description = "sample_update"
//        try! database.update(table: kSampleTable, on: Sample.Properties.description, with: object1, where: Sample.Properties.identifier > 0)
//
//        let objects11: [Sample] = try! database.getObjects(fromTable: kSampleTable)
//        print(objects11.first?.identifier ?? "--")
//        print(objects11.first?.description ?? "--")
//        
//        try! database.delete(fromTable: kSampleTable)
//   
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//}
