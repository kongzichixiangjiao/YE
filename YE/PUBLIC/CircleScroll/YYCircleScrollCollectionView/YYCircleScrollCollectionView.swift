//
//  YYCircleScrollCollectionView.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYCircleScrollCollectionView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightText
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = YYCircleScrollCollectionViewLayout()
        let model = YYCircleScrollViewManagerModel()
        model.myItemSize = CGSize(width: self.width - 100, height: self.height - 40)
        layout.model = model
        let v = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        // *** //
        v.isPagingEnabled = false;
        v.backgroundColor = UIColor.lightGray
        v.delegate = self
        v.dataSource = self
        v.register(UINib(nibName: "YYCircleScrollCollectionCell", bundle: nil), forCellWithReuseIdentifier: "YYCircleScrollCollectionCell")
        return v
    }()
    
}

extension YYCircleScrollCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YYCircleScrollCollectionCell", for: indexPath) as! YYCircleScrollCollectionCell
        if (indexPath.row == 0 || indexPath.row == 10) {
            cell.bigImageView.image = UIImage(named: "")
        } else {
            cell.bigImageView.image = UIImage(named: "2.jpg")
        }
        cell.label.text = String(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

class YYCircleScrollViewManagerModel {
    var cellCount: Int = 0
    var myItemSize: CGSize = CGSize.zero
    var isHorizontal: Bool = true
    var isScale: Bool = true
    var isAnimated: Bool = false
    var isConstraint: Bool = true
    var lineSpacing: CGFloat = -100
    var interitemSpacing: CGFloat = 0
    
    var currentIndex: CGFloat = 0
}

class YYCircleScrollCollectionViewLayout: UICollectionViewFlowLayout {
    var top: CGFloat = 0
    private var left: CGFloat = 90
    private var right: CGFloat = 0
    var bottom: CGFloat = 0
    
    var model: YYCircleScrollViewManagerModel!
    
    override func prepare() {
        super.prepare()

        model.cellCount = collectionView!.numberOfItems(inSection: 0)

        let colletionViewW = collectionView!.bounds.size.width
        let w: CGFloat = model.myItemSize.width
        let h: CGFloat = model.myItemSize.height
        
        itemSize = CGSize(width: w , height: h)

        // 无漏出
        if (model.lineSpacing == 0 && colletionViewW != w) {
            model.lineSpacing = (colletionViewW - w) / 2
            sectionInset = UIEdgeInsetsMake(top, model.lineSpacing, bottom, model.lineSpacing)
        }
        
        // 漏出 lineSpace 越小 漏出越多
        if (model.lineSpacing != 0) {
            right = collectionView!.bounds.size.width / 2 - w / 2
            left = collectionView!.bounds.size.width / 2 - w / 2
            sectionInset = UIEdgeInsetsMake(top, left , bottom, right)
        }
        if model.isConstraint {
            if model.lineSpacing < 0 {
                model.isScale = true
                model.isAnimated = true
            }
        }
        
        minimumLineSpacing  = model.lineSpacing
        minimumInteritemSpacing = model.interitemSpacing
        scrollDirection = model.isHorizontal ? .horizontal : .vertical
    }
    // 内容区域总大小，不是可见区域
//    override var collectionViewContentSize: CGSize {
//        return CGSize(width: collectionView!.width, height: collectionView!.height)
//    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return super.layoutAttributesForItem(at: indexPath)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0.0, width:  self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        // 目标区域中包含的cell
        let attriArray = super.layoutAttributesForElements(in: targetRect)! as [UICollectionViewLayoutAttributes]
        // collectionView落在屏幕中点的x坐标
        let horizontalCenterX = proposedContentOffset.x + (self.collectionView!.bounds.width / 2.0)
        var offsetAdjustment = CGFloat(MAXFLOAT)
        for layoutAttributes in attriArray {
            let itemHorizontalCenterX = layoutAttributes.center.x
            // 找出离中心点最近的
            if(abs(itemHorizontalCenterX-horizontalCenterX) < abs(offsetAdjustment)) {
                offsetAdjustment = itemHorizontalCenterX-horizontalCenterX
            }
        }
        
        if (velocity.x > 0) {
            print("左滑\(velocity)")
            model.currentIndex = model.currentIndex + 1 - ((model.currentIndex >= CGFloat(model.cellCount) - 1) ? 1 : 0)
        } else if (velocity.x < 0) {
            print("右滑\(velocity)")
            model.currentIndex = model.currentIndex - 1 + (model.currentIndex - 1 < 0 ? 1 : 0)
        } else {
            print("当前\(velocity)")
        }
        let point = CGPoint(x: model.myItemSize.width * model.currentIndex + model.lineSpacing * model.currentIndex, y: proposedContentOffset.y)
        
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveLinear, animations: {
            
        }) { (b) in
            
        }
        self.collectionView!.setContentOffset(point, animated: model.isAnimated)
        return point
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        let centetX = collectionView!.contentOffset.x + collectionView!.frame.size.width/2
        for attrs in array! {
            let delta = abs(attrs.center.x - centetX)
            let scale = 1 - delta/collectionView!.frame.size.width
            
            attrs.transform = CGAffineTransform(scaleX: model.isScale ? scale : 1, y: model.isScale ? scale : 1)
        }
        return array
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
