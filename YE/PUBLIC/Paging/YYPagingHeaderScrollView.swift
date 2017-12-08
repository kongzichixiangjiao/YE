//
//  YYPagingHeaderScrollView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/31.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

public let kScrollHeaderViewHeight: CGFloat = 44

class YYPagingHeaderScrollView: UIView {
    
    fileprivate let kFontSize: CGFloat = 12
    fileprivate let kBigFontSize: CGFloat = 13
    
    var selectedButton: UIButton!
    
    var titles: [String] = [] {
        didSet {
            initViews()
        }
    }
    
    typealias ClickedHandler = (_ tag: Int) -> ()
    var clickedHandler: ClickedHandler!
    
    convenience init(frame: CGRect, handler: @escaping ClickedHandler) {
        self.init(frame: frame)
        self.tag = 99999
        self.clickedHandler = handler
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: kScrollHeaderViewHeight))
        v.tag = 99998
        v.showsVerticalScrollIndicator = false;
        v.showsHorizontalScrollIndicator = false;
        self.addSubview(v)
        return v
    }()
    
    lazy var lineView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: self.scrollView.frame.size.height - 1.0 / UIScreen.main.scale, width: self.scrollView.frame.size.width, height: 1.0 / UIScreen.main.scale))
        v.backgroundColor = "e4e1e4".color0X
        return v
    }()
    
    func initViews() {
        var offsetW: CGFloat = 0
        for (i , title) in titles.enumerated() {
            let count = titles.count
            let w: CGFloat = count >= 5 ? self.frame.size.width / 4 : self.frame.size.width / count.cgFloat
            let h: CGFloat = self.frame.size.height
            
            let b = UIButton()
            b.tag = i
            b.frame = CGRect(x: i.cgFloat * w, y: 0, width: w, height: h)
            b.setTitle(title, for: .normal)
            b.titleLabel?.font = UIFont.systemFont(ofSize: i == 0 ? kBigFontSize : kFontSize)
            b.setTitleColor("999999".color0X, for: .normal)
            b.setTitleColor("FF6E35".color0X, for: .selected)
            b.isSelected = i == 0
            b.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            self.scrollView.addSubview(b)
            
            if i == 0 {
                selectedButton = b
            }
            
            let vW: CGFloat = title.count.cgFloat * kBigFontSize
            let v = UIView()
            v.frame = CGRect(x: w / 2 - vW / 2, y: h - 2, width: vW, height: 2)
            v.backgroundColor = UIColor.orange
            v.tag = 1000 + i
            v.alpha = i != 0 ? 0 : 1
            b.addSubview(v)
            
            offsetW += w
        }
        scrollView.contentSize = CGSize(width: offsetW, height: scrollView.frame.size.height)
        
        self.addSubview(lineView)
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        setupViews(sender)
    }
    
    fileprivate func setupViews(_ sender: UIButton) {
        if sender.tag == selectedButton.tag {
            return
        }
        
        selectedButton.titleLabel?.font = UIFont.systemFont(ofSize: kFontSize)
        sender.titleLabel?.font = UIFont.systemFont(ofSize: kBigFontSize)
        
        selectedButton.isSelected = false
        (selectedButton.subviews.last!).alpha = 0
        
        sender.isSelected = !sender.isSelected
        selectedButton = sender
        
        setupOffset(sender)
        
        clickedHandler(sender.tag)
    }
    
    fileprivate func setupOffset(_ sender: UIButton) {
        UIView.animate(withDuration: 0.35) {
            (sender.subviews.last!).alpha = 1
        }
        
        if sender.tag != 0 && sender.tag != 1 && sender.tag != titles.count - 1 && sender.tag != titles.count - 2 {
            let x = sender.center.x - self.scrollView.frame.size.width / 2
            UIView.animate(withDuration: 0.35) {
                self.scrollView.contentOffset = CGPoint(x: x, y: 0)
            }
        } else {
            if sender.tag == 0 || sender.tag == 1 {
                UIView.animate(withDuration: 0.35) {
                    self.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                }
            }
            if sender.tag == titles.count - 1 || sender.tag == titles.count - 2 {
                UIView.animate(withDuration: 0.35) {
                    self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentSize.width - self.scrollView.frame.size.width, y: 0)
                }
            }
        }
    }
    
    func updateHeaderScrollViewWithTag(_ tag: Int) {
        let b = self.viewWithTag(tag)
        setupViews(b as! UIButton)
    }
    
    func updateHeaderScrollView(_ offsetX: CGFloat) {
        print(offsetX)
        /*
            + 向右
            - 向左
         */
        if offsetX < 0 {
            if selectedButton.tag == titles.count - 1 {
                return
            }
            let _ = self.viewWithTag(selectedButton.tag + 1) as! UIButton
//            b.setTitleColor(UIColor(red: 255.color255, green: 110.color255, blue: (53 + Int(offsetX)).color255, alpha: 1), for: .normal)
//            b.titleLabel?.font = UIFont.systemFont(ofSize: kFontSize + (-offsetX / self.frame.size.width))
        } else {
            if selectedButton.tag == 0 {
                return
            }
            let _ = self.viewWithTag(selectedButton.tag - 1) as! UIButton
//            b.setTitleColor(UIColor(red: 255.color255, green: 110.color255, blue: (53 + Int(offsetX)).color255, alpha: 1), for: .normal)
//            b.titleLabel?.font = UIFont.systemFont(ofSize: kFontSize + (offsetX / self.frame.size.width))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
