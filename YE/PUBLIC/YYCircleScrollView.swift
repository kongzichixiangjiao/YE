//
//  YYEventTopView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  轮播

import UIKit

public let kYYCircleScrollViewHeight: CGFloat = 400 * UIScreen.main.bounds.width / UIScreen.main.bounds.height
class YYCircleScrollView: UIView {
    
    var SCROLL_WIDTH: CGFloat = 0
    var SCROLL_HEIGHT: CGFloat = 0
    
    var scrollView: UIScrollView?     //轮播图
    var pageC: UIPageControl?         //小点
    var timer: Timer?               //定时器
    var isTimer: Bool = false
    //图片数组
    var scArray: [String]? {
        didSet {
            self.scArray!.insert(self.scArray!.last!, at: 0)
            self.scArray!.insert(self.scArray![1], at: self.scArray!.count)
            
            initViews()
            
            if isTimer {
                initTimer()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SCROLL_WIDTH = self.frame.size.width
        SCROLL_HEIGHT = self.frame.size.height
    }
    
    convenience init(frame: CGRect, isTimer: Bool = false) {
        self.init(frame: frame)
        self.isTimer = isTimer
    }
    
    private func initViews() {
        initScrollView()
        initImageViews()
        initPageControl()
    }
    
    private func initTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(change(timer:)), userInfo: nil, repeats: true)
    }
    
    private func initScrollView() {
        //初始化轮播图
        scrollView = UIScrollView.init(frame: self.bounds)
        //ScrollView背景颜色
        scrollView?.backgroundColor = UIColor.cyan
        //ScrollView滚动量
        scrollView?.contentSize = CGSize(width: SCROLL_WIDTH * CGFloat((scArray?.count)!), height: SCROLL_HEIGHT)
        //ScrollView偏移量
        scrollView?.contentOffset = CGPoint(x: SCROLL_WIDTH, y: 0)
        //是否按页滚动
        scrollView?.isPagingEnabled = true
        //是否显示水平滑条
        scrollView?.showsHorizontalScrollIndicator = false
        //协议
        scrollView?.delegate = self as UIScrollViewDelegate
        self.addSubview(scrollView!)
    }
    
    private func initImageViews() {
        guard let _ = scArray else {
            return;
        }
        
        //遍历图片数组
        for i in 0  ..< scArray!.count  {
            let str :String = scArray![i]
            let img = UIImage(named: str)
        
            let imgV :UIImageView = UIImageView()
            imgV.image = img
            imgV.backgroundColor = UIColor.lightGray
            imgV.clipsToBounds = true
            imgV.contentMode = .scaleAspectFill
            //设置图片位置及大小
            imgV.frame = CGRect(x: (CGFloat(i) * SCROLL_WIDTH),y: 0, width: SCROLL_WIDTH, height: SCROLL_HEIGHT)
            scrollView?.addSubview(imgV)
            
            //轻拍手势
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapImageV(tap:)))
            imgV.tag = 1000 + i
            //打开用户交互
            imgV.isUserInteractionEnabled = true
            //给图片添加轻拍手势
            imgV.addGestureRecognizer(tap)
        }
    }
    
    private func initPageControl() {
        //设置小点的位置大小
        pageC = UIPageControl.init(frame: CGRect(x: (SCROLL_WIDTH - 200) / 2, y: SCROLL_HEIGHT - 50, width: 200, height: 50))
        //设置小点背景色
        pageC?.backgroundColor = UIColor.clear
        //设置小点个数
        pageC?.numberOfPages = (scArray?.count)! - 2
        //设置小点当前页码颜色
        pageC?.currentPageIndicatorTintColor = UIColor.white
        //设置小点未选中页码颜色
        pageC?.pageIndicatorTintColor = UIColor.gray
        //设置当前选中页
        pageC?.currentPage = 0
        self.addSubview(pageC!)
    }
    
    //定时器执行方法
    func change(timer :Timer) {
        
        if pageC?.currentPage == (pageC?.numberOfPages)! - 1 {
            pageC?.currentPage = 0
        } else if (pageC?.currentPage)! < (pageC?.numberOfPages)! - 1 {
            pageC?.currentPage += 1
        }
        scrollView?.setContentOffset(CGPoint(x: (CGFloat(pageC!.currentPage + 1)) * self.frame.size.width, y: 0), animated: false)
    }
    
    //开启定时器
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(change(timer:)), userInfo: nil, repeats: true)
    }
    
    //关闭定时器
    func removeTimer() {
        timer?.invalidate()
    }
    
    //开始拖拽时调用
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //关闭定时器
        removeTimer()
    }
    
    //拖拽结束后调用
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //开启定时器
        if isTimer {
            addTimer()
        }
    }
    
    //轻拍事件
    func tapImageV(tap :UITapGestureRecognizer) {
        
        print((tap.view?.tag)! - 1001)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension YYCircleScrollView {
    //循环滚动方法
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let w: CGFloat = scrollView.frame.size.width
        let h: CGFloat = scrollView.frame.size.height
        let sW: CGFloat = scrollView.contentSize.width
        let offsetX: CGFloat = scrollView.contentOffset.x
        //如果图片在第一张的位置
        if scrollView.contentOffset.x == 0 {
            //就变到倒数第二张的位置上
            scrollView.scrollRectToVisible(CGRect(x: sW - 2 * w, y: 0,width: w, height: h), animated: false)
            //如果图片是倒数第一张的位置
        } else if scrollView.contentOffset.x == sW - w {
            //就变到第二张的位置
            scrollView .scrollRectToVisible(CGRect(x: w, y: 0, width: w, height: h), animated: false)
        }
        print(Int(offsetX / w))
        let page: Int = Int(offsetX / w) == 0 ? self.scArray!.count : (Int(offsetX / w) == self.scArray!.count - 1 ? 0 : Int(offsetX / w))
            
        print(page)
        pageC?.currentPage = page - 1
        
    }
}
