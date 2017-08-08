//
//  YYLiveListViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYLiveListViewController: YYBaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "直播"
        initCollectionView()
     
        self.collectionView.ga_addRefreshHeaderXIB(headerView: GA_AnimationRefreshHeaderView.loadView()) {
            [weak self] in
            if let weakSelf = self {
                print("开始刷新")
                DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * 1000 * 1000000)) / Double(NSEC_PER_SEC), execute: {
                    DispatchQueue.main.async {
                        weakSelf.collectionView.ga_XIBendRefreshing()
//                        weakSelf.collectionView.yy_empty(.noData, alertTitle: "没啥数据...")
//                        print("刷新结束")
                    }
                })
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func initCollectionView() {
        let layout = YYBaseCollectionViewControllerLayout()
        layout.myItemSize = CGSize(width: MainScreenWidth / 2 - 20, height: 145)
        layout.itemSpace = 10
        layout.isHorizontal = false
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        isShowTabbar = true
        collectionViewFrameType = .normal64
        registerNib(YYLiveCollectionViewCell.identifier)
    }
}

extension YYLiveListViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYLiveCollectionViewCell.identifier, for: indexPath) as! YYLiveCollectionViewCell
        cell.titleLabel.text = String("第\(indexPath.row)个")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.showView(text: "走开，被点我。")
    }
}
