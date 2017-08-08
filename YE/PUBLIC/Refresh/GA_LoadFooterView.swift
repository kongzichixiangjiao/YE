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
            switch self.state {
            case .start:
                self.refreshHandler()
                self.startAnimation()
                break
            case .ing:
                UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
                    self.scrollView.contentInset = UIEdgeInsetsMake(-RefreshKey.kContentInsetTop, 0, 0, 0)
                }, completion: { (finished) in
                    
                })
                animationing()
                break
            case .ed:
                UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
                    self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
                }, completion: { (finished) in
                    
                })
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
        }
    }
    
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
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == RefreshKey.kObserverContentOffset {
            let t = object as! UIScrollView
            let y: CGFloat = t.contentOffset.y
            print(y)
            if (y < 0) {
                return
            }
            if (self.state != .start && self.state != .ing) {
                if (-y >= 0) {
                    print("ed -- \(self.state)")
                    self.state = .ed
                } else {
                    if (self.state == .ed || self.state == .normal) {
                        print("pull -- \(self.state)")
                        self.state = .pull
                    }
                }
                
                if y >= RefreshKey.kContentOffsetMax && self.state != .normal {
                    self.state = .will
                    print("will -- \(self.state)")
                } else {
                    if y <= RefreshKey.kContentInsetTop && self.state != .ed {
                        print("pull1 -- \(self.state)")
                        self.state = .pull
                    }
                }
            } else {
                if self.scrollView.contentInset.top == RefreshKey.kContentInsetTop && self.state != .ing {
                    print("end -- \(self.state)")
                    self.state = .ed
                } else {
                    if self.state == .ing && self.scrollView.contentInset.top == 0 {
                        self.state = .ed
                        print("return ed -- \(self.state)")
                    }
                }
            }
            
            if !self.scrollView.isDragging {
                if self.state == .will {
                    self.state = .start
                    print("start -- \(self.state)")
                } else {
                    if self.state == .start {
                        self.state = .ing
                        print("ing -- \(self.state)")
                    } else {
                        if self.scrollView.contentInset.top == 0 {
                            self.state = .ed
                        }
                        print("else ing -- \(self.state)")
                    }
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
        
    }
    
    func animationing() {
        
    }
    
    func willAnimation() {
        
    }
}
