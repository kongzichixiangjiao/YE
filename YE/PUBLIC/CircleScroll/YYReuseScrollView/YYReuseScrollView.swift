 //
//  YYReuseScrollView.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  轮播scrollview

import UIKit

protocol YYReuseScrollViewDelegate: NSObjectProtocol {
    func re_scrollView(_ scrollView: YYReuseScrollView, heightForRowAt index: Int) -> CGFloat
    func re_numOfContentWithScrollView(_ scrollView: YYReuseScrollView) -> Int
    func re_scrollView(_ scrollView: YYReuseScrollView, cellFrame frame: CGRect, cellForRowAt index: Int) -> YYReuseScrollViewCell
    func re_scrollView(_ scrollView: YYReuseScrollView, didSelectRowAt index: Int)
    func re_scrollView(_ scrollView: YYReuseScrollView, didCurrentRowAt index: Int)
}

class YYReuseScrollView: UIView {
    
    weak var delegate: YYReuseScrollViewDelegate?
    
    // 子view所占比例
    var isAnimation: Bool = true
    var scale: CGFloat = 1.0 // 0.6~1.0
    // 左边距
    var marginX: CGFloat = 0 // 0~20
    // 子view所占比例 最大缩放比例
    var maxAnimationScale: CGFloat = 1 // 1～1.2
    // 子view所占比例 最小缩放比例
    var minAnimationScale: CGFloat = 1 // 0.6～1
    
    var subViewWidth: CGFloat = 0
    var point: CGPoint = CGPoint.zero
    var subViewFrame: CGRect = CGRect.zero
    
    var subViewAry: [UIView] = [] //容器数组
    var reuseViewAry: [YYReuseScrollViewCell] = Array() //复用池view数组
    var userViewAry: [UIView] = [] //在使用view数组
    
    var index: Int = 0 //标记数据源位置
    var cellNum: Int = 0  //单元格 数量
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect.zero)
        v.backgroundColor = UIColor.clear
        v.isPagingEnabled = true
        v.showsHorizontalScrollIndicator = false
        v.delegate = self
        self.addSubview(v)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDefault()
        setSubView()
    }
    
    fileprivate func setDefault() {
        subViewWidth = self.frame.size.width * scale
        point = CGPoint(x: subViewWidth*2, y: 0)
        subViewFrame = CGRect(x: marginX, y: 0, width: subViewWidth - marginX*2, height: self.frame.size.height)
    }
    
    fileprivate func setSubView() {
        scrollView.frame = CGRect(x: (self.frame.size.width - subViewWidth)/2, y: 0, width: subViewWidth, height: self.frame.size.height)
        scrollView.contentSize = CGSize(width: subViewWidth*5, height: self.frame.size.height)
        
        subViewAry.removeAll()
        let _ = scrollView.subviews.map { v in
            v.removeFromSuperview()
        }
        
        for i in 0..<5 {
            let sub = UIView(frame: CGRect(x: CGFloat(i)*subViewWidth, y: 0, width: subViewWidth, height: self.frame.size.height))
            self.scrollView.addSubview(sub)
            subViewAry.append(sub)
        }
        
        if (isAnimation) {
            for sub in subViewAry {
                sub.layer.transform = CATransform3DMakeScale(minAnimationScale, minAnimationScale, 1)
            }
            
            let sub = subViewAry[2]
            sub.layer.transform = CATransform3DMakeScale(maxAnimationScale, maxAnimationScale, 1)
        }
    }
    
    // 开始渲染
    public func startRender() {
        setDefault()
        setSubView()
        upConfiger()
    }
    
    fileprivate func upConfiger() {
        checkOffset()
        checkCellnum()
        refreshCell()
        currentIndex()
    }
    
    fileprivate func checkOffset() {
        self.scrollView.contentOffset = point
    }
    //更新Cellnum
    fileprivate func checkCellnum() {
        cellNum = (delegate?.re_numOfContentWithScrollView(self))!
    }
    //更新显示数据
    fileprivate func refreshCell() {
        let indexAry = checkIndexAry()
        for i in 0..<5 {
            let indx = indexAry[i]
            let subView = subViewAry[i]
            for sub in subView.subviews {
                let s = sub as! YYReuseScrollViewCell
                s.isUser = false
                userViewAry.remove(at: i)
                reuseViewAry.append(s)
                s.removeFromSuperview()
            }
            
            let sub_view = delegate!.re_scrollView(self, cellFrame: subViewFrame, cellForRowAt: indx)
            sub_view.delegate = self
            sub_view.isUser = true
            userViewAry.append(sub_view)
            subView.addSubview(sub_view)
        }
    }
    //返回当前index
    fileprivate func currentIndex() {
        delegate?.re_scrollView(self, didCurrentRowAt: index)
    }
    
    fileprivate func checkIndexAry() -> [Int] {
        if (index < 0) {
            index = index + cellNum
        }
        if (index > cellNum) {
            index = 0
        }
       
        var index0 = index - 2
        var index1 = index - 1
        let index2 = index
        var index3 = index + 1
        var index4 = index + 2
        
        if (index0 < 0) {
            index0 = cellNum + index0
        }
        
        if (index1 < 1) {
            index1 = cellNum + index1
        }
        
        if (index3 >= cellNum) {
            index3 = index3 - cellNum
        }
        
        if (index4 >= cellNum) {
            index4 = index4 - cellNum
        }
        
        return [index0, index1, index2, index3, index4]
    }
    
    public func dequeueReuseCell(identifier: String) -> YYReuseScrollViewCell? {
        for i in 0..<reuseViewAry.count {
            let sub = reuseViewAry[i]
            if (sub.identifier == identifier && !sub.isUser) {
                DispatchQueue.main.async {
                    self.reuseViewAry.remove(at: self.reuseViewAry.index(of: sub)!)
                }
                
                return sub
            }
        }
        
        return nil
    }
    
    func animation() {
        if (!isAnimation) {
            return
        }
        let subView = self.subViewAry[2]
        let subViewLeft = self.subViewAry[1]
        let subViewRight = self.subViewAry[3]
        
        let sum = self.scrollView.contentOffset.x + subViewWidth / 2
        let centerX = subView.center.x
        let diff = sum - centerX
        let shortX = subViewWidth
        
        if (centerX <= sum && fabs(diff) <= shortX) {
            //向左滑动
            let scale = maxAnimationScale - fabs(diff)/shortX *  (maxAnimationScale - minAnimationScale)
            subView.layer.transform = CATransform3DMakeScale(scale, scale, 1.0)
            let scale1 = minAnimationScale+fabs(diff)/shortX * (maxAnimationScale - minAnimationScale)
            subViewRight.layer.transform = CATransform3DMakeScale(scale1, scale1, 1.0)
        }
        
        if (centerX >= sum && fabs(diff) <= shortX) {
            //向右滑动
            let scale = maxAnimationScale - fabs(diff)/shortX * (maxAnimationScale - minAnimationScale)
            subView.layer.transform = CATransform3DMakeScale(scale, scale, minAnimationScale)
            let scale1 = minAnimationScale+fabs(diff)/shortX * (maxAnimationScale - minAnimationScale)
            subViewLeft.layer.transform = CATransform3DMakeScale(scale1, scale1, 1.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

 extension YYReuseScrollView: YYReuseScrollViewCellDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        //判断左滑右滑
        if (contentOffsetX >= subViewWidth * 3) {
            //offset向右滑动 +1
            index += 1;
            //更新offset 刷新cell
            upConfiger()
        }else if (contentOffsetX <= subViewWidth){
            //向左滑动
            index -= 1;
            //更新offset 刷新cell
            upConfiger()
        }
        animation()
    }
    
    func didSelectedRespond() {
        delegate?.re_scrollView(self, didSelectRowAt: index)
    }
}















