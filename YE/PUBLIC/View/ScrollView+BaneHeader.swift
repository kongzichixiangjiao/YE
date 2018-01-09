//
//  ScrollView+HeaderExtesnion.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/7/31.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  Bane：dota中痛苦之源
//  滑动控制header图片大小

import UIKit

struct YYBaneHeaderKey {
    static var kHeaderView: UInt = 4000001
    static let kObserverContentOffset: String = "contentOffset"
    static let kHeight: CGFloat = 200
    
    static let kHeadPortraitButtonWidth: CGFloat = 50
    typealias Handler = ()->()
}

enum YYBaneHeaderType: Int {
    case normal = 0, header = 1, other = 2
}

protocol YYBaneHeaderProtocol {
    var baneHeaderView: YYBaneHeaderView { set get }
}

extension UIScrollView: YYBaneHeaderProtocol {
    
    var baneHeaderView: YYBaneHeaderView {
        get {
            guard let baneHeaderView = objc_getAssociatedObject(self, &YYBaneHeaderKey.kHeaderView) else {
                let v = YYBaneHeaderView(frame: CGRect.zero)
                v.backgroundColor = UIColor.orange
                objc_setAssociatedObject(self, &YYBaneHeaderKey.kHeaderView, v, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                self.addSubview(v)
                return v
            }
            return baneHeaderView as! YYBaneHeaderView
        }
        set {
            
        }
    }
    
    func yy_addBaneHeaderView(_ type: YYBaneHeaderType, bgImage: UIImage, height: CGFloat, handler: YYBaneHeaderKey.Handler?) -> UIView {
        self.baneHeaderView.frame = CGRect(x: 0, y: -height, width: self.frame.size.width, height: height)
        self.baneHeaderView.setupBGImage(bgImage)
        self.baneHeaderView.scrollView = self
        self.baneHeaderView.contentInset = self.contentInset
        self.baneHeaderView.type = type
        self.baneHeaderView.handler = handler
        
        var insets = self.contentInset
        insets.top = height
        self.contentInset = insets
        self.contentOffset = CGPoint(x: 0, y: -height)
        return self.baneHeaderView
    }
    
    func setupHeaderViewData(_ headerImage: UIImage?, userName: String) {
        self.baneHeaderView.setupHeaderViewData(headerImage, userName: userName)
    }
}

class YYBaneHeaderView: UIView {
    
    var type: YYBaneHeaderType! {
        didSet {
            initViews()
        }
    }
    var handler: YYBaneHeaderKey.Handler!
    
    var contentInset: UIEdgeInsets!
    
    var headPortraitButton: UIButton!
    var userNameLabel: UILabel!
    
    lazy var imageView: UIImageView = {
        let v = UIImageView(frame: self.bounds)
        v.layer.masksToBounds = true
        self.addSubview(v)
        return v
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let e = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effect = UIVisualEffectView(effect: e)
        effect.frame = self.imageView.bounds
        return effect
    }()
    
    var scrollView: UIScrollView! {
        didSet {
            scrollView.addObserver(self, forKeyPath: YYBaneHeaderKey.kObserverContentOffset, options: .new, context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == YYBaneHeaderKey.kObserverContentOffset {
//            let t = object as! UIScrollView
//            let y: CGFloat = t.contentOffset.y
//            if (y < -YYBaneHeaderKey.kHeight) {
//                let yOffset: CGFloat = y * -1
//                
//                let w = (self.frame.size.width / self.frame.size.height) * yOffset
//                let x = -(w - self.scrollView.frame.size.width) / 2
//                self.frame = CGRect(x: x, y: y, width: w, height: yOffset)
//                self.imageView.frame = self.bounds
//                self.effectView.frame = self.bounds
//                setupHeadPortraitButtonFrame()
//                setupUserNameLabelFrame()
//            }
//        }
    }
    
    func setupBGImage(_ image: UIImage) {
        self.imageView.image = image
        self.imageView.addSubview(self.effectView)
    }
    
    func initViews() {
        switch self.type.rawValue {
        case YYBaneHeaderType.normal.rawValue:
            break
        case YYBaneHeaderType.header.rawValue:
            initHeaderView()
            break
        case YYBaneHeaderType.other.rawValue:
            break
        default:
            break
        }
    }
    
    func initHeaderView() {
        headPortraitButton = UIButton()
        headPortraitButton.backgroundColor = UIColor.brown
        headPortraitButton.layer.cornerRadius = YYBaneHeaderKey.kHeadPortraitButtonWidth / 2
        headPortraitButton.layer.masksToBounds = true
        setupHeadPortraitButtonFrame()
        headPortraitButton.addTarget(self, action: #selector(headPortraitButtonAction(_:)), for: .touchUpInside)
        self.addSubview(headPortraitButton)
        
        userNameLabel = UILabel()
        setupUserNameLabelFrame()
        userNameLabel.font = UIFont.systemFont(ofSize: 13)
        userNameLabel.textColor = UIColor.white
        userNameLabel.textAlignment = .center
        userNameLabel.text = "侯佳男"
        self.addSubview(userNameLabel)
    }
    
    @objc func headPortraitButtonAction(_ sender: UIButton) {
        self.handler()
    }
    
    func setupHeadPortraitButtonFrame() {
        let w: CGFloat = YYBaneHeaderKey.kHeadPortraitButtonWidth
        let x: CGFloat = self.frame.size.width / 2 - w / 2
        let y: CGFloat = 50
        headPortraitButton.frame = CGRect(x: x, y: y, width: w, height: w)
    }
    
    func setupUserNameLabelFrame() {
        let w: CGFloat = self.frame.size.width
        let x: CGFloat = 0
        let y: CGFloat = headPortraitButton.frame.origin.y + YYBaneHeaderKey.kHeadPortraitButtonWidth + 15
        userNameLabel.frame = CGRect(x: x, y: y, width: w, height: 15)
    }
    
    func setupHeaderViewData(_ headerImage: UIImage?, userName: String) {
        self.userNameLabel.text = userName
        guard let image = headerImage else {
            return
        }
        self.headPortraitButton.setImage(image, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
