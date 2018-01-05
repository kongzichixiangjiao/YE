//
//  GA_RefreshOther.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

struct RefreshKey {

    static let kObserverContentOffset: String = "contentOffset"

    static let kContentInsetTop: CGFloat = 64
    static let kContentOffsetMax: CGFloat = 80
    
    typealias RefreshFinishedHandler = () -> ()
    
    static let kRefreshHeaderViewTag: Int = 2019
    
    static let kLoadFooterViewTag: Int = 2020
}

enum RefreshState: Int {
    case normal = -1, start = 0, ing = 1, ed = 2, will = 3, pull = 4
}

@objc
protocol GA_RefreshAnimationProtocol {
    func startAnimation()
    func willAnimation()
    func stopAnimation()
    func animationing()
    func pullAnimation()
}

public extension CGFloat {
    
    public func toRadians() -> CGFloat {
        return (self * CGFloat(Double.pi)) / 180.0
    }
    
    public func toDegrees() -> CGFloat {
        return self * 180.0 / CGFloat(Double.pi)
    }
}

class GA_RefreshBaseView: UIView {
    static let height: CGFloat = 64
    
    var scrollView: UIScrollView! {
        didSet {
            scrollView.addObserver(self, forKeyPath: RefreshKey.kObserverContentOffset, options: .new, context: nil)
        }
    }
    
    var refreshHandler: RefreshKey.RefreshFinishedHandler!
    
    var contentInset: UIEdgeInsets!
    
}
