//
//  YYJFHomeNewsScrollViewCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/6.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

class YYJFHomeNewsScrollViewCell: UICollectionViewCell {

    static let identifier: String = "YYJFHomeNewsScrollViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(scrollADView)
    }

    lazy var scrollADView: YYScrollADView = {
        let model = YYScrollADViewModel()
        model.text = "举起酒杯 干了欢乐泪水 不同的你我 真心面对 啊 真心面对"
        let model1 = YYScrollADViewModel()
        model1.text = "征途漫漫 和你一起追 生命这一刻 一起高飞 啊 一起高飞"
        let s = YYScrollADView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: kYYScrollADViewHeight), models: [model, model1], isShowIcon: true) {
            print("--YYScrollADView--")
        }
        return s
    }()
    
    func refresh(text: String) {
        scrollADView.refresh(text: "半年又半年 何其多？")
    }
}
