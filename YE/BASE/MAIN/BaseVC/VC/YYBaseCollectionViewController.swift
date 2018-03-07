//
//  YYBaseCollectionViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum YYCollectionViewKind: String {
    case header = "header", footer = "footer"
}

class YYBaseCollectionViewController: YYBaseViewController {
    
    open var dataSource: [Any] = []
    
    open var isShowTabbar: Bool = false
    
    open var isCancleX: Bool = false
    
    open var collectionViewFrameType: SaveAreaBottomSpaceType! {
        didSet {
            let y: CGFloat = (isShowNavigationView ? self.navigationView.frame.size.height : 0) + kNavigationViewBottomSpace
            var insets = UIEdgeInsets.zero
            let height = MainScreenHeight - y - (self.isShowTabbar ? TabBarHeight : 0)
            if UIDevice.current.isX {
                if #available(iOS 11.0, *) {
                    insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
                }
            }
            self.collectionView.frame = CGRect(x: 0, y: y + (self.isCancleX ? 0 : insets.bottom), width: MainScreenWidth, height: height)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = YYBaseCollectionViewControllerLayout()
        layout.myItemSize = CGSize(width: 50, height: 50)
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        v.backgroundColor = UIColor.white
        v.delegate = self
        v.dataSource = self
        self.view.addSubview(v)
        return v
    }()
    
    func registerClass(_ classString: String) {
        collectionView.register(NSClassFromString(classString), forCellWithReuseIdentifier: classString)
    }
    
    func registerNib(_ nibString: String) {
        collectionView.register(UINib(nibName: nibString, bundle: nil), forCellWithReuseIdentifier: nibString)
    }
    
    func registerNibSection(_ nibString: String, kind: String) {
        collectionView.register(UINib(nibName: nibString, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: nibString)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionViewFrameType = .normal44
    }
    
    func initCollectionView() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension YYBaseCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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

class YYBaseCollectionViewControllerLayout: UICollectionViewFlowLayout {
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

