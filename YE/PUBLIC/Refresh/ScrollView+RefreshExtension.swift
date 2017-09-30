//
//  ScrollView+Extension.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/28.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

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
        headerView.contentInset = self.contentInset
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

extension UIScrollView: UIScrollViewRefreshXIBProtocol {
    
    func ga_addRefreshHeaderXIB(_ headerView: GA_XIBRefreshHeaderView, _ handler: @escaping RefreshKey.RefreshFinishedHandler) {
        headerView.tag = RefreshKey.kRefreshHeaderViewTag
        self.addSubview(headerView)
        headerView.scrollView = self
        headerView.contentInset = self.contentInset
        headerView.refreshHandler = handler
        headerView.frame = CGRect(x: 0, y: -GA_XIBRefreshHeaderView.height - self.contentInset.top, width: self.frame.size.width, height: GA_XIBRefreshHeaderView.height)
    }
    
    func ga_XIBbeginRefreshing() {
        let headerView = self.viewWithTag(RefreshKey.kRefreshHeaderViewTag) as! GA_XIBRefreshHeaderView
        headerView.beginRefreshing()
    }
    
    func ga_XIBendRefreshing() {
        let headerView = self.viewWithTag(RefreshKey.kRefreshHeaderViewTag) as! GA_XIBRefreshHeaderView
        headerView.endRefreshing()
    }
}

extension UIScrollView: UIScrollViewRemoveAllViewsProtocol {
    
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
        footerView.contentInset = self.contentInset
        footerView.refreshHandler = handler
    }
    
    func ga_beginLoadFooter() {
        
    }
    
    func ga_endLoadFooter() {
        let loadView = self.viewWithTag(RefreshKey.kLoadFooterViewTag) as! GA_LoadFooterView
        loadView.endLoadFooter()
    }
}



