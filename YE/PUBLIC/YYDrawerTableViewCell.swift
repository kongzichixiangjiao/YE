//
//  YYDrawerTableViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

// 示例
class YYDrawerTableViewCellNew: YYDrawerTableViewCell {
    
    static let identifier1 = "YYDrawerTableViewCellNew"
    
    public override class func custom(tableView: UITableView, handler: @escaping ScrollDidselectedHandler, clickedHandler:
        @escaping ClickedHandler) -> YYDrawerTableViewCellNew {
        var cell = tableView.dequeueReusableCell(withIdentifier: YYDrawerTableViewCellNew.identifier1)
        if cell == nil {
            cell = YYDrawerTableViewCellNew(identifier: YYDrawerTableViewCellNew.identifier1, titles: ["删除", "赞", "扯淡", "吃饭"], handler: handler, clickedHandler: clickedHandler)
        }
        return cell! as! YYDrawerTableViewCellNew
    }
    
    override func initUI(titles: [String]) {
        super.initUI(titles: titles)
        let v = UIView()
        v.frame = CGRect(x: 10, y: 10, width: 10, height: 100);
        v.backgroundColor = UIColor.orange
        self.myContentView.addSubview(v)
    }
}

class YYDrawerTableViewCell: UITableViewCell {
    
    static let identifier = "YYDrawerTableViewCell"
    static let bWidth: CGFloat = 60
    
    typealias ScrollDidselectedHandler = (_ : Int, _ : Any?) -> ()
    fileprivate var scrollDidselectedHandler: ScrollDidselectedHandler?
    
    typealias ClickedHandler = (_ : Int) -> ()
    fileprivate var clickedHandler: ClickedHandler?
    
    fileprivate var myMaskView: UIView?
    
    public var myRow: Int = 0
    public var titles: [String] = []
    public var buttons: [UIButton] = []
    
    fileprivate lazy var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.backgroundColor = UIColor.white
        s.isPagingEnabled = true
        s.delegate = self
        s.showsVerticalScrollIndicator = false
        s.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(s)
        return s
    }()
    
    public lazy var myContentView: UIView = {
        let  v = UIView()
        v.backgroundColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyContentView(sender:)))
        tap.delegate = self
        v.addGestureRecognizer(tap)
        
        self.scrollView.addSubview(v)
        return v
    }()
    
    @objc private func actionb() {
        self.myMaskView?.removeFromSuperview()
        self.myMaskView = nil
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint.zero
        }
    }
    
    func tapMyContentView(sender: UITapGestureRecognizer) {
        self.scrollDidselectedHandler!(self.myRow, nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width + YYDrawerTableViewCell.bWidth * CGFloat(self.buttons.count), height: self.scrollView.frame.size.height)
        self.myContentView.frame = self.scrollView.bounds;
        
        for (index, value) in self.buttons.enumerated() {
            value.frame = CGRect(x: self.scrollView.frame.size.width + CGFloat(index) * YYDrawerTableViewCell.bWidth, y: 0, width: YYDrawerTableViewCell.bWidth, height: self.scrollView.frame.size.height)
        }
    }
    
    convenience init(identifier: String, titles: [String], handler: @escaping ScrollDidselectedHandler, clickedHandler:
        @escaping ClickedHandler) {
        self.init(style: .default, reuseIdentifier: identifier)
        self.scrollDidselectedHandler = handler
        self.clickedHandler = clickedHandler
        
        initUI(titles: titles)
    }
    
    public func initUI(titles: [String]) {
        for (index, value) in titles.enumerated() {
            let b = UIButton()
            b.backgroundColor = UIColor.randomColor()
            b.setTitle(value, for: .normal)
            b.tag = index
            b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            b.setTitleColor(UIColor.red, for: .normal)
            b.addTarget(self, action: #selector(actionb), for: .touchUpInside)
            self.scrollView.addSubview(b)
            self.buttons.append(b)
        }
    }
    
    public class func custom(tableView: UITableView, handler: @escaping ScrollDidselectedHandler, clickedHandler:
        @escaping ClickedHandler) -> YYDrawerTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: YYDrawerTableViewCell.identifier)
        if cell == nil {
            cell = YYDrawerTableViewCell(identifier: YYDrawerTableViewCell.identifier, titles: [], handler: handler, clickedHandler: clickedHandler)
        }
        return cell! as! YYDrawerTableViewCell
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func initMaskView() -> UIView {
        guard let maskView = self.myMaskView else {
            let v = UIView()
            v.frame = self.alertWhiteWindow.bounds
            v.backgroundColor = UIColor.clear
            //            v.alpha = 0.3
            v.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
            tap.delegate = self
            v.addGestureRecognizer(tap)
            
            self.alertWhiteWindow.addSubview(v)
            return v
        }
        return maskView
    }
    
    @objc private func tap(sender: UITapGestureRecognizer) {
        
    }
}

extension YYDrawerTableViewCell {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: nil)
        var frames: [CGRect] = []
        for b in self.buttons {
            let frame = b.convert(b.bounds, to: nil)
            frames.append(frame)
        }
        
        if (scrollView.contentOffset.x != 0) {
            self.myMaskView?.removeFromSuperview()
            self.myMaskView = nil
            
            self.alertWhiteWindow.ga_dissmissWhiteWindow()
            
            UIView.animate(withDuration: 0.3) {
                self.scrollView.contentOffset = CGPoint.zero
            }
            
            for (index, frame) in frames.enumerated() {
                if frame.contains(point) {
                    self.clickedHandler!(index)
                    return false
                }
            }
        }
        
        return true
    }
}

extension YYDrawerTableViewCell {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x != 0) {
            self.myMaskView = initMaskView()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    }
}
