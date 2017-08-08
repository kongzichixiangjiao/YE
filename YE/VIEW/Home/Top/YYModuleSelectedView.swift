//
//  YYCollectionView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYModuleSelectedView: YYBaseView {

    typealias DidSelectItemAtHandler = (_ row: Int) -> ()
    var didSelectItemAtHandler: DidSelectItemAtHandler?
    
    var data: [[String : Any]]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    lazy var layout: YYCollectionLayout = {
       let l = YYCollectionLayout()
        l.myItemSize = CGSize(width: self.frame.size.width / 4  - 10, height: self.frame.size.height)
        l.itemSpace = 10
        
        l.isHorizontal = true
        return l
    }()
    
    lazy var collectionView: YYBaseCollectionView = {
        let v = YYBaseCollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        v.delegate = self
        v.dataSource = self
        v.registerNib(kYYModuleSelectedCell)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(collectionView)
    }
    
    convenience init(frame: CGRect, handler: @escaping DidSelectItemAtHandler) {
        self.init(frame: frame)
        self.didSelectItemAtHandler = handler
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YYModuleSelectedView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else {
            return 3
        }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YYModuleSelectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: kYYModuleSelectedCell, for: indexPath) as! YYModuleSelectedCell
        cell.iconImageView.image = UIImage(named: self.data?[indexPath.row]["icon"] as! String)
        cell.titleLabel.text = self.data?[indexPath.row]["title"] as? String
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectItemAtHandler?(indexPath.row)
    }
}
