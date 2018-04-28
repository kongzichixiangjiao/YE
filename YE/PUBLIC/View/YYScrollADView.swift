//
//  YYScrollADView.swift
//  YE
//
//  Created by 侯佳男 on 2018/3/5.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

public let kYYScrollADViewHeight: CGFloat = 40

enum YYScrollADViewType: Int {
    case normal = 0, continuous = 1, normalNeed = 2
}

enum YYScrollADViewDirection: Int {
    case left = 0, right = 1
}

class YYScrollADViewModel {
    var font: UIFont = UIFont.systemFont(ofSize: 12)
    var direction: YYScrollADViewDirection = .left
    var type: YYScrollADViewType = .continuous
    var textWidth: CGFloat = 0

    var text: String = "" {
        didSet {
            self.textWidth = (text as NSString).size(withAttributes: [NSAttributedStringKey.font : font]).width
        }
    }
    var speed = 0.01
}

class YYScrollADView: UIView {
    
    var model: YYScrollADViewModel!
    var timer: Timer?
    var isShowIcon: Bool = false
    
    private let kTextSpace: CGFloat = 100
    
    typealias TouchBeganHandler = () -> ()
    var touchBeganHandler: TouchBeganHandler?
    
    lazy var bgImageView: UIImageView = {
        let img = UIImage(named: "home_shadow")
        let i = UIImageView(image: img)
        i.frame = CGRect(x: 0, y: 0, width: img?.size.width ?? 0, height: img?.size.height ?? 0)
        return i
    }()
    
    lazy var iconImageView: UIImageView = {
        let img = UIImage(named: "event_collect")
        let i = UIImageView(image: img)
        i.frame = CGRect(x: 0, y: (self.frame.size.height / 2) - (img?.size.height ?? 0) / 2, width: img?.size.width ?? 0, height: img?.size.height ?? 0)
        return i
    }()
    
    lazy var textView: UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.backgroundColor = UIColor.white
        return l
    }()
    
    lazy var textViewSuffix: UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.backgroundColor = UIColor.white
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgImageView)
    }
    
    convenience init(frame: CGRect, models: [YYScrollADViewModel], isShowIcon: Bool = false, touchBeganHandler: TouchBeganHandler?) {
        self.init(frame: frame)
        
        self.model = models[0]
        
        self.isShowIcon = isShowIcon
        
        self.touchBeganHandler = touchBeganHandler
        
        startScroll()
        
        showIconImage(isShowIcon: isShowIcon)
    }
    
    private func showIconImage(isShowIcon: Bool) {
        if isShowIcon {
//            self.insertSubview(iconImageView, at: 10)
            self.addSubview(iconImageView)
        }
    }
    
    private func startScroll() {
        var x: CGFloat = 0
        var xSuffix: CGFloat = 0
        switch model.direction {
        case .left:
            switch model.type {
            case .normal:
                x = self.frame.size.width
                break
            case .continuous:
                x = self.frame.size.width
                xSuffix = self.frame.size.width + model.textWidth + kTextSpace
                break
            case .normalNeed:
                x = self.frame.size.width
            }
            break
        case .right:
            switch model.type {
            case .normal:
                x = -model.textWidth
                break
            case .continuous:
                x = -model.textWidth
                xSuffix = -model.textWidth*2
                break
            case .normalNeed:
                break
            }
            break
        }
        
        textView.frame = CGRect(x: x, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        textView.text = model.text
        textView.font = model.font
        self.addSubview(textView)
        
        switch model.type {
        case .normal:
            timer = Timer(timeInterval: model.speed, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
            break
        case .continuous:
            textViewSuffix.frame = CGRect(x: xSuffix, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
            textViewSuffix.text = model.text
            textViewSuffix.font = model.font
            self.addSubview(textViewSuffix)
            
            timer = Timer(timeInterval: model.speed, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: .commonModes)
            break
        case .normalNeed:
            leftNormalNeed()
            break
        }
        
        self.insertSubview(iconImageView, at: 10)
    }
    
    @objc func scroll() {
        switch model.direction {
        case .left:
            switch model.type {
            case .normal:
                leftNormal()
                break
            case .continuous:
                leftContinuous()
                break
            case .normalNeed:
                leftNormalNeed()
                break
            }
            break
        case .right:
            switch model.type {
            case .normal:
                rightNormal()
                break
            case .continuous:
                rightContinuous()
                break
            case .normalNeed:
                break
            }
            break
        }
    }
    
    private func rightNormal() {
        textView.frame = CGRect(x: textView.frame.origin.x + 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (textView.frame.origin.x > self.frame.size.width) {
            textView.frame = CGRect(x: -model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    private func rightContinuous() {
        textView.frame = CGRect(x: textView.frame.origin.x + 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        textViewSuffix.frame = CGRect(x: textViewSuffix.frame.origin.x + 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (textView.frame.origin.x > self.frame.size.width) {
            textView.frame = CGRect(x: -model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
        if (textViewSuffix.frame.origin.x > self.frame.size.width) {
            textViewSuffix.frame = CGRect(x:  textView.frame.origin.x - model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    private func leftNormal() {
        textView.frame = CGRect(x: textView.frame.origin.x - 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (-textView.frame.origin.x > model.textWidth) {
            textView.frame = CGRect(x: self.frame.size.width, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    private func leftContinuous() {
        if (textViewSuffix.frame.origin.x + textViewSuffix.frame.width != 0) {
            textView.frame = CGRect(x: textView.frame.origin.x - 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
        if (textView.frame.origin.x + textView.frame.width != 0) {
            textViewSuffix.frame = CGRect(x: textViewSuffix.frame.origin.x - 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
        
        if (textView.frame.origin.x + textView.width <= 0) {
            if (textViewSuffix.frame.origin.x + textViewSuffix.width <= self.frame.size.width - kTextSpace) {
                textView.frame = CGRect(x: self.frame.size.width, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
            }
        }
        if (textViewSuffix.frame.origin.x + textViewSuffix.frame.width <= 0) {
            if (textView.frame.origin.x + textView.width <= self.frame.size.width - kTextSpace) {
                textViewSuffix.frame = CGRect(x: self.frame.size.width, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
            }
        }
    }
    
    private func leftNormalNeed() {
        let b = CABasicAnimation(keyPath: "position")
        b.fromValue = NSValue(cgPoint: CGPoint(x: self.frame.size.width + model.textWidth / 2, y: kYYScrollADViewHeight / 2))
        b.toValue = NSValue(cgPoint: CGPoint(x: self.frame.size.width - model.textWidth / 2, y: kYYScrollADViewHeight / 2))
        b.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        b.repeatCount = MAXFLOAT
        b.duration = 5
        textView.layer.add(b, forKey: "p")
    }
    
    public func refresh(text: String) {
        model.text = text 
        textView.layer.removeAnimation(forKey: "p")
        startScroll()
    }
    
    private func stopScroll() {
        self.timer?.invalidate()
    }
    
    deinit {
        stopScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        touchBeganHandler?()
    }
    
}
