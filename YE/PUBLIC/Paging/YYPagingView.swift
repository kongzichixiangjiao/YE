//
//  YYPagingView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/31.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  

import UIKit

class YYPagingView: UIView {

    typealias PageHandler = (_ page: Int) -> ()
    var pageHandler: PageHandler?
    
    var vcs: [UIViewController]!
    
    convenience init(frame: CGRect, vcs: [UIViewController], handler: @escaping PageHandler) {
        self.init(frame: frame)
        self.vcs = vcs
        self.pageHandler = handler
        
        initViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    lazy var scrollHeaderView: YYPagingHeaderScrollView = {
        let v = YYPagingHeaderScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: kScrollHeaderViewHeight), handler: {
            [weak self] tag in
            if let weakSelf = self {
                weakSelf.setupScrollViewOffset(tag)
            }
        })
        self.addSubview(v)
        return v
    }()
    
    func setupScrollViewOffset(_ tag: Int) {
        UIView.animate(withDuration: 0.25) {
            self.scrollView.contentOffset = CGPoint(x: tag.cgFloat * self.scrollView.frame.size.width, y: 0)
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: self.scrollHeaderView.frame.size.height, width: self.frame.size.width, height: self.frame.size.height - kScrollHeaderViewHeight))
        v.showsVerticalScrollIndicator = false;
        v.showsHorizontalScrollIndicator = false;
        v.isPagingEnabled = true
        v.delegate = self
        self.addSubview(v)
        return v
    }()
    
    func initViews() {
        var titles: [String] = []
        
        for (i, vc) in vcs.enumerated() {
            titles.append(vc.title ?? "--")
            vc.view.frame = CGRect(x: i.cgFloat * scrollView.frame.size.width, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            scrollView.addSubview(vc.view)
        }
        
        scrollView.contentSize = CGSize(width: self.frame.size.width * vcs.count.cgFloat, height: self.frame.size.height - kScrollHeaderViewHeight)
        self.scrollHeaderView.titles = titles
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollHeaderView.updateHeaderScrollView(endOffsetX - scrollView.contentOffset.x)
    }
    
    var endOffsetX: CGFloat = 0
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollHeaderView.updateHeaderScrollViewWithTag(Int(scrollView.contentOffset.x / self.frame.size.width))
        endOffsetX = scrollView.contentOffset.x
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
