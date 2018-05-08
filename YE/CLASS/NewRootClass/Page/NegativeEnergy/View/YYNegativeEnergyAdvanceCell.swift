//
//  YYNegativeEnergyAdvanceCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/7.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYNegativeEnergyAdvanceCell: UITableViewCell {

    static let identifier = "YYNegativeEnergyAdvanceCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [String] = ["程序猿", "胖子", "跑步", "怼", "吃便便", "搞事情"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initViews()
    }
    
    func initViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: YYNegativeEnergyAdvanceItemCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYNegativeEnergyAdvanceItemCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension YYNegativeEnergyAdvanceCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYNegativeEnergyAdvanceItemCell.identifier, for: indexPath) as! YYNegativeEnergyAdvanceItemCell
        cell.myTextLabel.text = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.size.width / 3 - 16, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dataSource[indexPath.row])
    }
    
}
