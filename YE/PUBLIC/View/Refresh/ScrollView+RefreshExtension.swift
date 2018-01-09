//
//  ScrollView+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  刷新 刷新 刷新

import UIKit

protocol UIScrollViewRefreshProtocol {
    func ga_addRefreshHeader(_ headerView: GA_RefreshHeaderView, _ handler: @escaping RefreshKey.RefreshFinishedHandler)
    
    func ga_beginRefreshing()
    
    func ga_endRefreshing()
}

protocol UIScrollViewLoadProtocol {
    func ga_addLoadFooter(_ footerView: GA_LoadFooterView, _ handler: @escaping RefreshKey.RefreshFinishedHandler)
    
    func ga_beginLoadFooter()
    
    func ga_endLoadFooter()
}

protocol UIScrollViewRefreshXIBProtocol {
    func ga_addRefreshHeaderXIB(_ headerView: GA_XIBRefreshHeaderView, _ handler: @escaping RefreshKey.RefreshFinishedHandler)
    
    func ga_XIBbeginRefreshing()
    
    func ga_XIBendRefreshing()
}

protocol UIScrollViewRemoveAllViewsProtocol {
    func ga_removeAllViews()
}

extension UIScrollView: UIScrollViewRefreshProtocol {
    
    func ga_addRefreshHeader(_ headerView: GA_RefreshHeaderView, _ handler: @escaping RefreshKey.RefreshFinishedHandler) {
        headerView.tag = RefreshKey.kRefreshHeaderViewTag
        self.addSubview(headerView)
        headerView.scrollView = self
        headerView.sourceContentInset = self.contentInset
        headerView.refreshHandler = handler
        headerView.frame = CGRect(x: 0, y: -GA_XIBRefreshHeaderView.height - self.contentInset.top, width: self.frame.size.width, height: GA_RefreshHeaderView.height)
    }
    
    func ga_beginRefreshing() {
        let headerView = self.viewWithTag(RefreshKey.kRefreshHeaderViewTag) as! GA_RefreshHeaderView
        headerView.beginRefreshing()
    }
    
    func ga_endRefreshing() {
        let headerView = self.viewWithTag(RefreshKey.kRefreshHeaderViewTag) as! GA_RefreshHeaderView
        headerView.endRefreshing()
    }
    
}


// MARK: - 添加下拉刷新
extension UIScrollView: UIScrollViewRefreshXIBProtocol {
    
    func ga_addRefreshHeaderXIB(_ headerView: GA_XIBRefreshHeaderView, _ handler: @escaping RefreshKey.RefreshFinishedHandler) {
        headerView.tag = RefreshKey.kRefreshHeaderViewTag
        self.addSubview(headerView)
        headerView.scrollView = self
        headerView.sourceContentInset = self.contentInset
        headerView.refreshHandler = handler
        headerView.frame = CGRect(x: 0, y: -GA_XIBRefreshHeaderView.height - self.contentInset.top, width: self.frame.size.width, height: GA_XIBRefreshHeaderView.height)
    }
    
    public func ga_XIBbeginRefreshing() {
        guard let headerView = self.viewWithTag(RefreshKey.kRefreshHeaderViewTag) as? GA_XIBRefreshHeaderView else {
            return
        }
        headerView.beginRefreshing()
    }
    
    public func ga_XIBendRefreshing() {
        guard let headerView = self.viewWithTag(RefreshKey.kRefreshHeaderViewTag) as? GA_XIBRefreshHeaderView else {
            return
        }
        headerView.endRefreshing()
    }
}
// MARK: - 添加上拉加载
extension UIScrollView: UIScrollViewRemoveAllViewsProtocol {
    
    // 此方法有毒 剧毒
    func ga_removeAllViews() {
        for v in self.subviews {
            if (NSStringFromClass(type(of: v)).components(separatedBy: ".").last! == "_UIFieldEditorContentView") {
            } else {
                v.removeFromSuperview()
            }
        }
    }
    
    open override func removeFromSuperview() {
        super.removeFromSuperview()
//        ga_removeAllViews()
    }
}

extension UIScrollView: UIScrollViewLoadProtocol {
    func ga_addLoadFooter(_ footerView: GA_LoadFooterView, _ handler: @escaping RefreshKey.RefreshFinishedHandler) {
        footerView.tag = RefreshKey.kLoadFooterViewTag
        footerView.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 64)
        self.addSubview(footerView)
        footerView.scrollView = self
        footerView.sourceContentInset = self.contentInset
        footerView.refreshHandler = handler
    }
    
    public func ga_beginLoadFooter() {
        
    }
    
    public func ga_endLoadFooter() {
        guard let loadView = self.viewWithTag(RefreshKey.kLoadFooterViewTag) as? GA_LoadFooterView else {
            return
        }
        loadView.endLoadFooter()
    }
}
