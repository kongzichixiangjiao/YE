//
//  YYReuseScrollViewCell.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/22.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

protocol YYReuseScrollViewCellDelegate: class {
    func didSelectedRespond()
}

class YYReuseScrollViewCell: UIView {

    weak var delegate: YYReuseScrollViewCellDelegate?
    var identifier: String = ""
    var isUser: Bool = false // 是否在使用
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.backgroundColor = UIColor.orange
        l.frame = CGRect.zero
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 40)
        return l
    }()
    
    lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.frame = CGRect.zero
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, identifier: String) {
        self.init(frame: frame)
        self.identifier = identifier
        
        initViews()
    }
    
    func initViews() {
        imageView.frame = self.bounds
        self.addSubview(imageView)
    }
    
}
