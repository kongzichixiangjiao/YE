//
//  PXCustomsFormViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class PXCustomsFormViewController: UIViewController {

    var dataSource: [PXCustomsFormModel] = []
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        self.view.addSubview(v)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initViews()
    }
    
    func initData() {
        let path = Bundle.yy_plistPath(.cutomsForm)
        
        let arr = NSArray.init(contentsOf: URL(fileURLWithPath: path)) as! [[String : Any]]
        if let list = ([PXCustomsFormModel].deserialize(from: arr) as? [PXCustomsFormModel]) {
            self.dataSource = list
        }
    }
    
    func initViews() {
        collectionView.frame = self.view.bounds
        collectionView.register(UINib(nibName: PXCustomsFormTextCell.identifier, bundle: nil), forCellWithReuseIdentifier: PXCustomsFormTextCell.identifier)
        collectionView.register(UINib(nibName: PXCustomsFormHeaderCell.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PXCustomsFormHeaderCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension PXCustomsFormViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PXCustomsFormTextCell.identifier, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PXCustomsFormHeaderCell.identifier, for: indexPath)
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let obj = self.dataSource[section]
        return obj.items.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.width, height: 63)
    }
}
