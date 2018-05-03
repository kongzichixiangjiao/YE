//
//  YYJFTreasureViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/9.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYJFTreasureViewController: YYBaseCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCollectionView()
        
        let image = UIImage(named: "treasure_bottom_bg")
        let v = UIImageView(image: image)
        v.frame = self.view.bounds
        v.contentMode = .bottom
        collectionView.addSubview(v)
        
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func initCollectionView() {
        self.isZeroStart = true
        let space: CGFloat = 10
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: collectionView.frame.size.width / 2 - space, height: YYJFTreasureItemCell.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: MainScreenWidth, height: YYJFTreasureHeaderView.height)
        
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = UIColor.clear
        collectionViewFrameType = .normal0
        registerNib(YYJFTreasureItemCell.identifier)
        registerNibSection(YYJFTreasureHeaderView.identifier, kind: UICollectionElementKindSectionHeader)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}
extension YYJFTreasureViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: YYJFTreasureHeaderView.identifier, for: indexPath)
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYJFTreasureItemCell.identifier, for: indexPath) as! YYJFTreasureItemCell
            return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.showView("走开，被点我。")
    }

}
