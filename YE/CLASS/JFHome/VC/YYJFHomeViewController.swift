//
//  YYJFHomeViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/6.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum JFHomePushType: Int {
    case hdgl = 0, yygl = 1, gtjl = 2, wdkh = 3, cpzx = 4, xxpl = 5, mrfx = 6, cpxx = 7, hydj = 8, jcsj = 9
}

enum JFHomeCellType: Int {
    case circleView = 0, newsView = 1, sortView = 2
}

class YYJFHomeViewController: YYBaseCollectionViewController {

    var dataArray: [[String : Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "JF首页"
        self.setupRightButton(.normal)
        self.setupOtherRightButton(title: "show")
        
        initCollectionView()
        
        let path = Bundle.main.path(forResource: "jf_home", ofType: "plist")
        dataArray = NSArray.init(contentsOf: URL(fileURLWithPath: path!)) as! [[String : Any]]
        collectionView.reloadData()
    }
    
    override func clickedRightButtonAction(_ sender: UIButton) {
        self.yy_showTopSheet(message: "我是测试", isNav: true)
    }
    
    override func clickedNavigationViewOtherRightButton(_ sender: UIButton) {
        self.yy_hideTopSheet(isNav: true)
    }
    
    override func initCollectionView() {
        let layout = YYBaseCollectionViewControllerLayout()
        layout.itemSpace = 0
        layout.isHorizontal = false
//        layout.headerReferenceSize = CGSize(width: MainScreenWidth, height: YYJFHomeViewHeaderReusableView.height)
        // 判断系统版本9.0以后才有这个功能
        if (UIDevice.current.systemVersion.toDouble() ?? 0 >= 9.0) {
            
            // 当前组如果还在可视范围时让头部视图停留
            layout.sectionHeadersPinToVisibleBounds = true;
            
            // 当前组如果还在可视范围时让尾部视图停留
            layout.sectionFootersPinToVisibleBounds = true;
        }
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isScrollEnabled = true
        
        collectionViewFrameType = .normal44
        registerNib(YYJFHomeCell.identifier)
        registerNib(YYJFHomeCircleViewCell.identifier)
        registerNib(YYJFHomeNewsScrollViewCell.identifier)
        registerNibSection(YYJFHomeViewHeaderReusableView.identifier, kind: UICollectionElementKindSectionHeader)
    }
    
    var maxY: CGFloat = 0
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPostion = scrollView.contentOffset.y

        if (currentPostion <= 0) {
            return
        }
        if (currentPostion - self.maxY > 20) {
            self.maxY = currentPostion
            print("up")
            if currentPostion > YYJFHomeNewsScrollViewCell.height + YYJFHomeCircleViewCell.height {
                return
            }
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                self.collectionView.contentOffset = CGPoint(x: 0, y: YYJFHomeNewsScrollViewCell.height + YYJFHomeCircleViewCell.height)
            }, completion: nil)
            
        } else if (self.maxY - currentPostion > 20) {
            self.maxY = currentPostion
            if currentPostion > YYJFHomeNewsScrollViewCell.height + YYJFHomeCircleViewCell.height {
                return
            }
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .curveEaseOut, animations: {
                self.collectionView.contentOffset = CGPoint(x: 0, y: 0)
            }, completion: nil)
            print("down")
        }
    }
}

extension YYJFHomeViewController: YYJFHomeCellDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: YYJFHomeViewHeaderReusableView.identifier, for: indexPath)
            return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case JFHomeCellType.circleView.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYJFHomeCircleViewCell.identifier, for: indexPath) as! YYJFHomeCircleViewCell
            return cell
        case JFHomeCellType.newsView.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYJFHomeNewsScrollViewCell.identifier, for: indexPath) as! YYJFHomeNewsScrollViewCell
            cell.refresh(text: "")
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYJFHomeCell.identifier, for: indexPath) as! YYJFHomeCell
            cell.titleLabel.text = dataArray[indexPath.row - JFHomeCellType.sortView.rawValue]["title"] as? String
            cell.model = dataArray[indexPath.row - JFHomeCellType.sortView.rawValue]["data"] as! [[String : Any]]
            cell.myDelegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case JFHomeCellType.circleView.rawValue:
            return CGSize(width: MainScreenWidth, height: YYJFHomeCircleViewCell.height)
        case JFHomeCellType.newsView.rawValue:
            return CGSize(width: MainScreenWidth, height: YYJFHomeNewsScrollViewCell.height)
        default:
            return CGSize(width: MainScreenWidth, height: YYJFHomeCell.height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count + 2
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.showView("走开，被点我。")
    }
    
    func jfHomeClickedItem(type: JFHomePushType) {
        print(type)
    }
    
}
