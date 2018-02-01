//
//  GA_LoadFooterView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/6.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class GA_LoadMoreView : GA_LoadFooterView {
    
    lazy var titleLable: UILabel = {
        let v = UILabel()
        v.text = "加载更多"
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 14)
        return v
    }()
    
    override func initViews() {
        super.initViews()
        self.addSubview(self.titleLable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLable.frame = self.bounds
    }
}

class GA_LoadFooterView: GA_RefreshBaseView {
    
    var state: RefreshState = .ed {
        didSet {
            if currentState == state {
                return
            }
            switch self.state {
            case .start:
                self.refreshHandler()
                self.startAnimation()
                break
            case .ing:
                animationing()
                break
            case .ed:
                stopAnimation()
                break
            case .will:
                willAnimation()
                break
            case .pull:
                pullAnimation()
                break
            case .normal:
                break
            }
            currentState = state
        }
    }
    
    var currentState: RefreshState = .pull
    
    func beginLoadFooter() {
        self.state = .start
        self.state = .ing
    }
    
    func endLoadFooter() {
        self.state = .ed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.state = .normal
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func initViews() {
        DispatchQueue.main.async {
            self.frame = CGRect(x: 0, y: self.scrollView.contentSize.height, width: self.scrollView.frame.size.width, height: 64)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == RefreshKey.kObserverContentOffset {
            let t = object as! UIScrollView
            print(t.decelerationRate)
            let tHeight: CGFloat = t.frame.size.height
            let contentSizeHeight = t.contentSize.height
            let y: CGFloat = t.contentOffset.y
            
            if y < 0 {
                DispatchQueue.main.async {
                    self.frame = CGRect(x: 0, y: self.scrollView.contentSize.height, width: self.scrollView.frame.size.width, height: 64)
                }
                return
            }
            
            if (self.state != .start && self.state != .ing) {
                if contentSizeHeight + RefreshKey.kContentOffsetMax - tHeight < y && self.state != .normal  && self.state != .will {
                    self.state = .will
                } else {
                    self.state = .pull
                    self.frame = CGRect(x: 0, y: t.contentSize.height, width: self.scrollView.frame.size.width, height: 64)
                }
            }
            
            if !self.scrollView.isDragging {
                if self.state == .will {
                    self.state = .start
                }
                if self.state == .start {
                    self.state = .ing
                }
            }
        }
    }
    
    deinit {
        self.state = .ed
        guard let s = self.scrollView else {
            return
        }
        s.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        s.removeObserver(self, forKeyPath: RefreshKey.kObserverContentOffset)
    }
}

extension GA_LoadFooterView: GA_RefreshAnimationProtocol {
    func pullAnimation() {
        
    }
    
    func startAnimation() {
        
    }
    
    func stopAnimation() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
                self.scrollView.contentInset = UIEdgeInsetsMake(self.sourceContentInset.top, self.sourceContentInset.left, self.sourceContentInset.bottom, self.sourceContentInset.right)
            }, completion: { (finished) in
                self.frame = CGRect(x: 0, y: self.scrollView.contentSize.height, width: self.scrollView.frame.size.width, height: 64)
            })
        }
    }
    
    func animationing() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
            self.scrollView.contentInset = UIEdgeInsetsMake(self.sourceContentInset.top, self.sourceContentInset.left, self.sourceContentInset.bottom + RefreshKey.kContentOffsetMax, self.sourceContentInset.right)
        }, completion: { (finished) in
            
        })
    }
    
    func willAnimation() {
        
    }
}
