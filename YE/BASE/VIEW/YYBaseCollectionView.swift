//
//  YYCollectionView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit


class YYBaseCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        backgroundColor = UIColor.white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func registerClass(_ classString: String) {
        register(NSClassFromString(classString), forCellWithReuseIdentifier: classString)
    }
    
    func registerNib(_ nibString: String){
        register(UINib(nibName: nibString, bundle: nil), forCellWithReuseIdentifier: nibString)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YYBaseCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

class YYCollectionLayout: UICollectionViewFlowLayout {
    var myItemSize: CGSize = CGSize.zero
    var itemSpace: CGFloat = 0
    var isHorizontal: Bool = true
    var myMinimumLineSpacing: CGFloat = 0
    var mymMinimumLineSpacing: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        let w: CGFloat = myItemSize.width
        let h: CGFloat = myItemSize.height
        let space: CGFloat = itemSpace
        
        itemSize = CGSize(width: w , height: h)
        sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        minimumLineSpacing  = space
        minimumInteritemSpacing = space
        scrollDirection = isHorizontal ? .horizontal : .vertical
    }
}

class YYCollectionLayoutManager {
    var width: CGFloat = 0
    var height: CGFloat = 0
}
