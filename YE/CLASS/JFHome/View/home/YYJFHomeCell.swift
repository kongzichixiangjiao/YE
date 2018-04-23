//
//  YYJFHomeCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/6.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

protocol YYJFHomeCellDelegate: NSObjectProtocol {
    func jfHomeClickedItem(type: JFHomePushType)
}

class YYJFHomeCell: UICollectionViewCell {

    static let identifier: String = "YYJFHomeCell"
    static let height: CGFloat = MainScreenWidth * 312 / 750
    
    weak var myDelegate: YYJFHomeCellDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: [[String : Any]]! {
        didSet {
            print(model)
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: MainScreenWidth / 4, height: MainScreenWidth / 4)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: YYJFHomeItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYJFHomeItemCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

extension YYJFHomeCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYJFHomeItemCell.identifier, for: indexPath) as! YYJFHomeItemCell
        cell.imageView.image = UIImage(named: model[indexPath.row]["icon"] as! String)
        cell.titleLabel.text = model[indexPath.row]["name"] as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(model[indexPath.row]["push"] ?? "")
        myDelegate?.jfHomeClickedItem(type: JFHomePushType(rawValue: model[indexPath.row]["push"] as! Int)!)
    }
    
}
