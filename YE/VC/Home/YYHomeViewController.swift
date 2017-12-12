//
//  YYYeEventViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
//import SQLite
import Then

class YYTestView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let _ = test(nil, event: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func test(_ point: CGPoint?, event: UIEvent?) -> UIView? {
        if isUserInteractionEnabled || !isHidden || alpha < 0.01 {
            return nil
        }
        if !self.point(inside: point!, with: event) {
            return nil
        }
        for view in self.subviews {
            let childP = self.convert(point!, to: view)
            let fitView = view.hitTest(childP, with: event)
            if (fitView != nil) {
                return fitView
            }
        }
        return self
    }
    
    var pp: Int = 0
    
    override var description: String {
        print(self.pp.description)
        return self.pp.description
    }
}

class YYChildTestView: YYTestView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let father = YYTestView()
        var count: UInt32 = 0
        let vars = class_copyIvarList(YYTestView.classForCoder(), &count)
        
        for i in 0..<count {
            let ivar: Ivar = vars![Int(i)]
            print(String(utf8String: ivar_getName(ivar)!) ?? "--")
            object_setIvar(father, ivar, 333)
            print(father.description)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class YYHomeViewController: YYBaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        
        initTableView()
        
        sqliteMethod()
        
        let _ = YYChildTestView(frame: CGRect.zero)
        
        myC()
    }
    
    func myC() {
        c_main()
        c_sum(2, 2)
    }
    
    func swift4() {
        //
        //        let a = 10
        //        print( a * 10 )
        
        /*
         let galaxy = "Milky Way "
         galaxy.count       // 11
         galaxy.isEmpty     // false
         galaxy.dropFirst() // "ilky Way "
         String(galaxy.reversed()) // " yaW ykliM"
         
         // Filter out any none ASCII characters
         galaxy.filter { char in
         let isASCII = char.unicodeScalars.reduce(true, { $0 && $1.isASCII })
         return isASCII
         } // "Milky Way "
         
         var str = "Hello, playground"
         // Swift3.0
         var index = str.index(of: " ")!
         let greeting = str[str.startIndex ..< index]
         index = str.index(index, offsetBy: 1) // index 下标 +1
         let name = str[index ..< str.endIndex]
         // Swift4.0
         var index1 = str.index(of: " ")!
         let greeting1 = str.prefix(upTo: index1)
         index1 = str.index(index1, offsetBy: 1)
         let name1 = str.suffix(from: index1)
         print(Array(str.enumerated()))
         print(Array(zip(1..., str)))
         
         /// plist格式
         let plistInfo = """
         <?xml version="1.0" encoding="UTF-8"?>
         <plist version="1.0">
         <array>
         <dict>
         <key>title</key>
         <string>设置WiFi</string>
         <key>imageName</key>
         <string>serversSet</string>
         </dict>
         </array>
         </plist>
         """
         /// JSON格式
         let jsonInfo = """
         {
         "data": {
         "title": "String is a collection"
         "author": "23"
         "creat_at": "2017-06-13"
         }
         }
         """
         print(plistInfo)
         print(jsonInfo)
         
         var str1 = "Hello, Swift 4.0"
         print(str1.characters.count) // Swift3.0写法
         print(str1.count)            // Swift4.0写法
         /// 遍历
         str1.forEach {
         print($0)
         }
         
         let nearestStarNames = ["Proxima Centauri", "Alpha Centauri A", "Alpha Centauri B", "Barnard's Star", "Wolf 359"]
         let nearestStarDistances = [4.24, 4.37, 4.37, 5.96, 7.78]
         
         // Dictionary from sequence of keys-values
         let starDistanceDict = Dictionary(uniqueKeysWithValues: zip(nearestStarNames, nearestStarDistances))
         print(starDistanceDict)
         */
    }
    
    func sqliteMethod() {
        /*
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let db = try? Connection("\(path)/db.sqlite3")
        
        let users = Table("users")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
        try! db?.run(users.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: true)
            table.column(name)
            table.column(email, unique: true)
        }))
 */
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    func initNavigationView() {
        self.myTitle = "首页"
        self.leftButtonTitle = "home_nav_scan"
        self.setupRightButton(.details)
        self.setupOtherRightButton()

    }
        
    override func initTableView() {
        saveAreaBottomSpaceType = .normal44
//        registerNibWithIdentifier(kYYHomeBasicCell)
        
        registerClassWithIdentifier(YYDrawerTableViewCellNew.identifier)
        
        tableView.tableHeaderView = initTableViewHeaderView()
        self.footerView()
    }
    
    func initTableViewHeaderView() -> UIView {
        let w: CGFloat = tableView.frame.size.width
        
        let tableHeaderView = YYHomeTopView(frame: CGRect(x: 0, y: 0, width: w, height: kYYCircleScrollViewHeight + kYYModuleSelectedCellHeight + 10)) {
            [weak self] row in
            if let weakSelf = self {
                weakSelf.topViewModuleSelected(row)
            }
        }
        tableHeaderView.showLineView(10)
        
        let imageNames = ["IMG_2787.jpg", "IMG_3260.JPG", "IMG_2719.jpg", "IMG_3027.jpg"]
        tableHeaderView.imageNames = imageNames
        tableHeaderView.data = [["title" : "活动", "icon" : "home_middle_activity"], ["title" : "直播", "icon" : "home_middle_live"], ["title" : "周边", "icon" : "home_middle_surrounding"], ["title" : "文章", "icon" : "home_middle_article"]]
        
        return tableHeaderView
    }
    
    // MARK: 轮播广告图点击事件
    func topViewModuleSelected(_ row: Int) {
        switch row {
        case 0:
            self.push(YYActivityListViewController())
            break
        case 1:
            self.push(YYCompetitionListViewController())
            break
        case 2:
            self.push(YYLiveListViewController())
            break
        case 3:
            self.push(YYSurroundingListViewController())
            break
        case 4:
            self.push(YYArticleListViewController())
            break
        default:
            break
        }
    }
    
    // MARK: 扫码事件
    override func clickedLeftButtonAction() {
        print("扫码")
    }
    
    override func clickedRightButtonAction(_ sender: UIButton) {
        push(YYTestViewController())
        let vc = UIStoryboard(name: "YYResizeImageViewController", bundle: nil).instantiateInitialViewController()
//        push(vc!)
    }
    
    override func clickedNavigationViewOtherRightButton(_ sender: UIButton) {
//        push(YYEventDetailViewController())
        push(YYPlayerViewController(nibName: "YYPlayerViewController", bundle: nil))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension YYHomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = YYDrawerTableViewCellNew.custom(tableView, handler: {
            [weak self] row, obj in
            if let _ = self {
                print("row: \(row)")
                
                let vc = YYAlertViewController()
                if row == 0 {
                    vc.yy_showText("佳能 佳能佳能")
                } else if (row == 1) {
                    vc.yy_showLoading()
                } else if (row == 2) {
                    vc.yy_showImage_text(.error, text: "成功成功成功")
                } else if (row == 3) {
                    vc.yy_showSelected("佳能6D2", data: ["1", "2", "3"], handler: {
                        [weak self] row, value in
                        if let _ = self {
                            print("row: \(row), value: \(String(describing: value))")
                        }
                    })
                } else {
                    
                }
            }
        }) {
            [weak self] tag in
            if let _ = self {
                print("tag: \(tag)")
            }
        }
        cell.myRow = indexPath.row
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return Bundle.main.loadNibNamed("YYHomeSectionView", owner: self, options: nil)?.last as? UIView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            self.view.ga_showSelectedLoading(data: ["12", "22", "32", "42", "52"], handler: { (row, obj) in
                print(row, obj ?? "")
            })
        } else if (indexPath.row == 1) {
            print(self.view.alertWhiteWindow)
        } else {
            self.view.ga_hideSelectedLoading()
        }
    }
}
