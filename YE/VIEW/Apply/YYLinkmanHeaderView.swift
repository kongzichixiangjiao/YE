//
//  YYLinkmanHeaderView.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/8/2.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYLinkmanHeaderView: UIView {

    static let height: CGFloat = 50
    
    typealias LinkmanHandler = (_ tag: Int) -> ()
    var linkmanHandler: LinkmanHandler!
    
    var titles: [String] = []
    private let bW: CGFloat = 50
    private let space: CGFloat = 10
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView.init(frame: self.bounds)
        v.contentSize = CGSize(width: (self.space + self.bW) * (self.titles.count).cgFloat, height: self.frame.size.height)
        v.showsHorizontalScrollIndicator = false
        v.delegate = self as UIScrollViewDelegate
        self.addSubview(v)
        return v
    }()
    
    convenience init(frame: CGRect, titles: [String], handler: @escaping LinkmanHandler) {
        self.init(frame: frame)
        linkmanHandler = handler
        self.titles = titles
        initViews(titles: titles)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews(titles: [String]) {
        for (i, title) in titles.enumerated() {
            let b = UIButton()
            b.tag = i 
            b.frame = CGRect(x: i.cgFloat * (space + bW) + space, y: 0, width: bW, height: self.frame.size.height)
            b.setTitle(title, for: .normal)
            b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            b.setTitleColor(UIColor.black, for: .normal)
            b.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            scrollView.addSubview(b)
        }
    }
    
    func buttonAction(sender: UIButton) {
        linkmanHandler(sender.tag)
    }
    
}
