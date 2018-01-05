//
//  YYDrawerTableViewCell.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  cell滑动出各种标签按钮

import UIKit

// 示例
/*
 class YYDrawerTableViewCellNew: YYDrawerTableViewCell {
 
 static let identifier1 = "YYDrawerTableViewCellNew"
 
 open override class func custom(_ tableView: UITableView, handler: @escaping ScrollDidselectedHandler, clickedHandler:
 @escaping ClickedHandler) -> YYDrawerTableViewCellNew {
 var cell = tableView.dequeueReusableCell(withIdentifier: YYDrawerTableViewCellNew.identifier1)
 if cell == nil {
 cell = YYDrawerTableViewCellNew(identifier: YYDrawerTableViewCellNew.identifier1, titles: ["删除", "赞", "扯淡", "吃饭"], handler: handler, clickedHandler: clickedHandler)
 }
 return cell! as! YYDrawerTableViewCellNew
 }
 
 override func initUI(_ titles: [String]) {
 super.initUI(titles)
 let v = UIView()
 v.frame = CGRect(x: 10, y: 10, width: 10, height: 100);
 v.backgroundColor = UIColor.orange
 self.myContentView.addSubview(v)
 }
 }
 */
open class YYDrawerTableViewCell: UITableViewCell {
    
    static let identifier = "YYDrawerTableViewCell"
    static let bWidth: CGFloat = 60
    
    public typealias ScrollDidselectedHandler = (_ : Int, _ : Any?) -> ()
    public var scrollDidselectedHandler: ScrollDidselectedHandler?
    
    public typealias ClickedHandler = (_ : Int, _ : Any?) -> ()
    public var clickedHandler: ClickedHandler?
    
    open var myRow: Int = 0
    open var titles: [String] = []
    open var buttons: [UIButton] = []
    
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
    
    open lazy var myContentView: UIView = {
        let  v = UIView()
        v.backgroundColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyContentView(_:)))
        tap.delegate = self
        v.addGestureRecognizer(tap)
        
        self.scrollView.addSubview(v)
        return v
    }()
    
    @objc fileprivate func actionb(sender: UIButton) {
        removeMaskView()
        
        self.clickedHandler!(sender.tag, buttons[sender.tag].titleLabel?.text)
    }
    
    private func removeMaskView() {
        dissmissWhiteWindow()
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint.zero
        }
    }
    
    @objc func tapMyContentView(_ sender: UITapGestureRecognizer) {
        self.scrollDidselectedHandler!(self.myRow, nil)
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: self.contentView.frame.size.height)
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width + YYDrawerTableViewCell.bWidth * CGFloat(self.buttons.count), height: self.scrollView.frame.size.height)
        self.myContentView.frame = self.scrollView.bounds;
        
        for (index, value) in self.buttons.enumerated() {
            value.frame = CGRect(x: self.scrollView.frame.size.width + CGFloat(index) * YYDrawerTableViewCell.bWidth, y: 0, width: YYDrawerTableViewCell.bWidth, height: self.scrollView.frame.size.height)
        }
    }
    
    public convenience init(identifier: String, titles: [String], handler: @escaping ScrollDidselectedHandler, clickedHandler:
        @escaping ClickedHandler) {
        self.init(style: .default, reuseIdentifier: identifier)
        self.scrollDidselectedHandler = handler
        self.clickedHandler = clickedHandler
        
        initUI(titles)
    }
    
    convenience public init(identifier: String) {
        self.init(style: .default, reuseIdentifier: identifier)
    }
    
    open func initUI(_ titles: [String]) {
        for (index, value) in titles.enumerated() {
            let b = UIButton()
            b.backgroundColor = UIColor.cell_randomColor()
            b.setTitle(value, for: .normal)
            b.tag = index
            b.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            b.setTitleColor(UIColor.red, for: .normal)
            b.addTarget(self, action: #selector(actionb(sender:)), for: .touchUpInside)
            self.scrollView.addSubview(b)
            self.buttons.append(b)
        }
    }
    
    open class func custom(_ tableView: UITableView, handler: @escaping ScrollDidselectedHandler, clickedHandler:
        @escaping ClickedHandler) -> YYDrawerTableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: YYDrawerTableViewCell.identifier)
        if cell == nil {
            cell = YYDrawerTableViewCell(identifier: YYDrawerTableViewCell.identifier, titles: [], handler: handler, clickedHandler: clickedHandler)
        }
        return cell! as! YYDrawerTableViewCell
    }
    
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    lazy var alertWhiteWindow: UIWindow? = {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.backgroundColor = UIColor.blue
        alertWindow.alpha = 0.3
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapWhiteWindow(_:)))
        alertWindow.addGestureRecognizer(tap)
        
        return alertWindow
    }()
    
    lazy var mMaskView: UIView? = {
        guard let win = UIApplication.shared.windows.first else {
            return nil
        }
        let v = UIView(frame: win.bounds)
        v.backgroundColor = UIColor.clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapWhiteWindow(_:)))
        tap.delegate = self
        v.addGestureRecognizer(tap)
        
        win.addSubview(v)
        return v
    }()
    
    @objc func tapWhiteWindow(_ sender: UITapGestureRecognizer) {
        removeMaskView()
    }
    
    func dissmissWhiteWindow() {
        mMaskView?.isHidden = true
        return
    }
    
    func showWhiteWindow() {
        mMaskView?.isHidden = false
        return
    }
}

extension YYDrawerTableViewCell {
    
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: nil)
        var frames: [CGRect] = []
        for b in self.buttons {
            let frame = b.convert(b.bounds, to: nil)
            frames.append(frame)
        }
        
        if (scrollView.contentOffset.x != 0) {
            removeMaskView()
            
            for (index, frame) in frames.enumerated() {
                if frame.contains(point) {
                    self.clickedHandler!(index, buttons[index].titleLabel?.text)
                    return false
                }
            }
        }
        
        return true
    }
}

extension YYDrawerTableViewCell: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x != 0) {
            showWhiteWindow()
        }
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}

