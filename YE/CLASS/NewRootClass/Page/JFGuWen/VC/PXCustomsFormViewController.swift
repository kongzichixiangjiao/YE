//
//  PXCustomsFormViewController.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/3.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum PXCustomsFormType: Int {
    case edit = 0, resubmit = 1, preview = 2
}

class PXCustomsFormViewController: UIViewController {

    private let kUploadImageSection = 3
    
    var pageType: PXCustomsFormType = .edit 
    
    var dataSource: [PXCustomsFormModel] = []
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false 
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapCollectionView(sender:)))
//        v.addGestureRecognizer(tap)
        self.view.addSubview(v)
        return v
    }()
    
    lazy var pickerView: PXDatePickerView = {
        let v = PXDatePickerView.loadDatePickerView()
        v.frame = CGRect(x: 0, y: self.view.size.height - 244, width: self.view.size.width, height: 244)
        v.datePickerViewClickedHandler = datePickerViewClickedHandler
        self.view.addSubview(v)
        return v
    }()

    lazy var datePickerViewClickedHandler: PXDatePickerView.PXDatePickerViewClickedHandler = {
        [weak self] tag, dateString in
        if let weakSelf = self {
            let obj = weakSelf.dataSource[1]
            let model = obj.items[0]
            model.placeText = dateString
            weakSelf.collectionView.reloadData()
            weakSelf.pickerView.isHidden = true
        }
    }
    
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
        collectionView.register(UINib(nibName: PXCustomsFormEditCell.identifier, bundle: nil), forCellWithReuseIdentifier: PXCustomsFormEditCell.identifier)
        collectionView.register(UINib(nibName: PXCustomsFormImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: PXCustomsFormImageCell.identifier)
        collectionView.register(UINib(nibName: PXCustomsFormHeaderCell.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: PXCustomsFormHeaderCell.identifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tapCollectionView(sender: UITapGestureRecognizer) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
}

extension PXCustomsFormViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = self.dataSource[indexPath.section]
        let model = obj.items[indexPath.row]
        if (indexPath.section == kUploadImageSection) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PXCustomsFormImageCell.identifier, for: indexPath) as! PXCustomsFormImageCell
            cell.model = model
            return cell
        }
        if (model.isEdit) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PXCustomsFormEditCell.identifier, for: indexPath) as! PXCustomsFormEditCell
            cell.model = model
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PXCustomsFormTextCell.identifier, for: indexPath) as! PXCustomsFormTextCell
        cell.model = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PXCustomsFormHeaderCell.identifier, for: indexPath) as! PXCustomsFormHeaderCell
        let obj = self.dataSource[indexPath.section]
        header.model = obj
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
        if (indexPath.section == kUploadImageSection) {
            return CGSize(width: self.view.width, height: 241)
        }
        return CGSize(width: self.view.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.width, height: 63)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.dataSource[indexPath.section]
        let model = obj.items[indexPath.row]
        if (indexPath.section == kUploadImageSection) {
            print("选择图片")
        }
        if (model.isClicked) {
            print("--pickerView--")
            pickerView.isHidden = false
        }
        
    }
}
