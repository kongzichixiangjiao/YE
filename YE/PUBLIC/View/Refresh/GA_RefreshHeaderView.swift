//
//  GA_RefreshHeaderView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/30.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class GA_RefreshHeaderView: GA_RefreshBaseView {
    
    var state: RefreshState = .ed {
        didSet {
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
        }
    }
    
    func beginRefreshing() {
        self.state = .start
        self.state = .ing
    }
    
    func endRefreshing() {
        self.state = .ed
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.orange
        self.state = .normal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
//        self.init(frame: CGRect(x: 0, y: -GA_RefreshHeaderView.height, width: UIScreen.main.bounds.width, height: GA_RefreshHeaderView.height))
        self.init()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == RefreshKey.kObserverContentOffset {
            let t = object as! UIScrollView
            let y: CGFloat = t.contentOffset.y
            if (y > 0) {
                return
            }
            if (self.state != .start && self.state != .ing) {
                if (y >= 0) {
                    self.state = .ed
                } else {
                    if (self.state == .ed || self.state == .normal) {
                        self.state = .pull
                    }
                }
                
                if -y >= RefreshKey.kContentOffsetMax && self.state != .normal {
                    self.state = .will
                } else {
                    if -y <= RefreshKey.kContentInsetTop && self.state != .ed {
                        self.state = .pull
                    }
                }
            } else {
                if self.scrollView.contentInset.top == RefreshKey.kContentInsetTop && self.state != .ing {
                    
                    self.state = .ed
                } else {
                    if self.state == .ing && self.scrollView.contentInset.top == 0 {
                        self.state = .ed
                    }
                }
            }
            
            // let hasTouch = self.panGestureRecognizer.numberOfTouches != 0
            if !self.scrollView.isDragging {
                if self.state == .will {
                    self.state = .start
                } else {
                    if self.state == .start {
                        self.state = .ing
                    } else {
                        if self.scrollView.contentInset.top == 0 {
                            self.state = .ed
                        }
                    }
                }
            }
        }
    }
    
    deinit {
        self.scrollView.contentInset = self.sourceContentInset
        self.scrollView.removeObserver(self, forKeyPath: RefreshKey.kObserverContentOffset)
        self.state = .ed
    }
}

extension GA_RefreshHeaderView: GA_RefreshAnimationProtocol {
    func pullAnimation() {
        
    }
    
    func startAnimation() {

    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
            self.scrollView.contentInset = self.sourceContentInset
        }, completion: { (finished) in
            
        })
    }
    
    func animationing() {

        UIView.animate(withDuration: 0.35, delay: 0, options: .allowUserInteraction, animations: {
            self.scrollView.contentInset = UIEdgeInsetsMake(RefreshKey.kContentInsetTop + self.sourceContentInset.top, self.sourceContentInset.left, self.sourceContentInset.bottom, self.sourceContentInset.right)
        }, completion: { (finished) in
            
        })
    }
    
    func willAnimation() {
        
    }
}


