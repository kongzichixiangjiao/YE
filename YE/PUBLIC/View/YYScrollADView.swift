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
    case normal = 0, continuous = 1
}

enum YYScrollADViewDirection: Int {
    case left = 0, right = 1
}

class YYScrollADViewModel {
    var font: UIFont = UIFont.systemFont(ofSize: 12)
    var direction: YYScrollADViewDirection = .right
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
    var timer: Timer!
    
    lazy var textView: UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.backgroundColor = UIColor.yellow
        return l
    }()
    
    lazy var textViewSuffix: UILabel = {
        let l = UILabel(frame: CGRect.zero)
        l.backgroundColor = UIColor.yellow
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, models: [YYScrollADViewModel]) {
        self.init(frame: frame)
        
        self.model = models[0]
        
        startScroll()
    }
    
    func startScroll() {
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
                xSuffix = self.frame.size.width + model.textWidth
                break
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
            }
            break
        }
        
        textView.frame = CGRect(x: x, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        textView.text = model.text
        textView.font = model.font
        self.addSubview(textView)
        
        switch model.type {
        case .normal:
            break
        case .continuous:
            textViewSuffix.frame = CGRect(x: xSuffix, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
            textViewSuffix.text = "-" + model.text
            textViewSuffix.font = model.font
            self.addSubview(textViewSuffix)
            break
        }
        
        timer = Timer(timeInterval: model.speed, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
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
            }
            break
        }
    }
    
    func rightNormal() {
        textView.frame = CGRect(x: textView.frame.origin.x + 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (textView.frame.origin.x > self.frame.size.width) {
            textView.frame = CGRect(x: -model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    func rightContinuous() {
        textView.frame = CGRect(x: textView.frame.origin.x + 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        textViewSuffix.frame = CGRect(x: textViewSuffix.frame.origin.x + 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (textView.frame.origin.x > self.frame.size.width) {
            textView.frame = CGRect(x: -model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
        if (textViewSuffix.frame.origin.x > self.frame.size.width) {
            textViewSuffix.frame = CGRect(x:  textView.frame.origin.x - model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    func leftNormal() {
        textView.frame = CGRect(x: textView.frame.origin.x - 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (-textView.frame.origin.x > model.textWidth) {
            textView.frame = CGRect(x: self.frame.size.width, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    func leftContinuous() {
        textView.frame = CGRect(x: textView.frame.origin.x - 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        textViewSuffix.frame = CGRect(x: textViewSuffix.frame.origin.x - 1, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        
        if (-textView.frame.origin.x > model.textWidth) {
            textView.frame = CGRect(x: self.frame.size.width, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
        if (-textViewSuffix.frame.origin.x > model.textWidth) {
            textViewSuffix.frame = CGRect(x:  textView.frame.origin.x + model.textWidth, y: 0, width: model.textWidth, height: kYYScrollADViewHeight)
        }
    }
    
    /*
     // 001
    @objc func scroll() {
        let b = CABasicAnimation(keyPath: "position")
        b.fromValue = NSValue(cgPoint: CGPoint(x: self.frame.size.width + model.textWidth, y: kYYScrollADViewHeight / 2))
        b.toValue = NSValue(cgPoint: CGPoint(x: -self.model.textWidth, y: kYYScrollADViewHeight / 2))
        b.repeatCount = MAXFLOAT
        b.duration = 5
        textView.layer.add(b, forKey: "p")
    }
    */
    
    func stopScroll() {
        self.timer.invalidate()
    }
    
    deinit {
        stopScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




























































