//
//  YYAutoScrollView.swift
//  YE
//
//  Created by 侯佳男 on 2017/11/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYAutoScrollView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {
        for i in 0..<10 {
            let imageView = UILabel(frame: CGRect.zero)
            if i == 0 {
                imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            } else {
                imageView.frame = CGRect(x: i * 30 + 40, y: 0, width: 40, height: 40)
            }
            imageView.backgroundColor = UIColor.orange
            imageView.text = String(i)
            imageView.textAlignment = .center
            self.addSubview(imageView)
        }
    }
    
    

}
