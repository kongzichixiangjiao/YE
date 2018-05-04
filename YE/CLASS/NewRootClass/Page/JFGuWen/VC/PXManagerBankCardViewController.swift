//
//  PXManagerBankCardViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class PXManagerBankCardViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        self.view.addSubview(v)
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        
    }
    
    func initViews() {
        let l = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 51))
        l.textAlignment = .center
        l.text = "向左滑动银行卡，进行操作！"
        let ima = UIImage(named: "im_friendList_select_selected")
        l.textColor = ima?.yy_mainColor // 333333
        l.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(l)
        
        collectionView.frame = CGRect(x: 0, y: 51, width: self.view.bounds.width, height: self.view.bounds.height - 51)
        collectionView.register(UINib(nibName: PXManagerBankCell.identifier, bundle: nil), forCellWithReuseIdentifier: PXManagerBankCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    lazy var clickedHandler: PXManagerBankCell.ClickedHandler = {
        [weak self] tag, obj in
        if let weakSelf = self {
            print(tag)
        }
    }
    
    lazy var scrollDidselectedHandler: PXManagerBankCell.ScrollDidselectedHandler = {
        [weak self] row, obj in
        if let weakSelf = self {
            print(row)
        }
    }
}

extension PXManagerBankCardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PXManagerBankCell.identifier, for: indexPath) as! PXManagerBankCell
        cell.myRow = indexPath.row
        cell.model = "2"
        cell.clickedHandler = clickedHandler
        cell.scrollDidselectedHandler = scrollDidselectedHandler
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


