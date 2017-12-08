//
//  YYReuseCollectionView.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/23.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYReuseCollectionView: UIView {
    
    var images: [UIImage] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        v.isPagingEnabled = true
        v.register(UINib(nibName: YYReuseCollectionCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYReuseCollectionCell.identifier)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, images: [UIImage]) {
        self.init(frame: frame)
    }
}

extension YYReuseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYReuseCollectionCell.identifier, for: indexPath) as! YYReuseCollectionCell
        cell.imageView.image = images[indexPath.row]
        cell.row = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1000000
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MainScreenWidth, height: 300)
    }
    
}
