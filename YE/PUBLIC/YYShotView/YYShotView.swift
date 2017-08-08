//
//  YYShotView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/7/13.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

extension YYShotView {
    var shotWindow: UIWindow {
        get {
            guard let window: UIWindow = objc_getAssociatedObject(self, &YYShotView.kShotWindow) as? UIWindow else {
                let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.backgroundColor = UIColor.clear
                alertWindow.becomeKey()
                alertWindow.makeKeyAndVisible()
                alertWindow.isHidden = false
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(tapshotWindow(sender:)))
                alertWindow.addGestureRecognizer(tap)
                
                objc_setAssociatedObject(self, &YYShotView.kShotWindow, alertWindow, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                
                return alertWindow
            }
            return window
        }
        set {

        }
    }
}

extension YYShotView {
    func tapshotWindow(sender: UITapGestureRecognizer) {
        shotDismissWindow()
    }
    
    fileprivate func shotDismissWindow() {
        self.shotWindow.resignKey()
        self.shotWindow.isHidden = true
        
        objc_setAssociatedObject(self, &YYShotView.kShotWindow, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.removeFromSuperview()
    }
}

class YYShotView: UIView {

    static var kShotWindow = 130001
    
    static let shotViewW: CGFloat = UIScreen.main.bounds.width * 0.34
    
    private let space: CGFloat = 10
    private let triangleLength: CGFloat = 10
    private let buttonH: CGFloat = 35
    
    private var buttons: [UIButton] = []
    
    typealias YYShotViewHandler = (_: String) -> ()
    var shotViewHandler: YYShotViewHandler?

    var pointX: CGFloat = 0
    
    class func show(point: UIView, items: [String] = [], handler: @escaping YYShotViewHandler) {
        let _ = YYShotView(size: CGSize(width: YYShotView.shotViewW, height: 100), pointView: point, items: items,  handler: handler)
    }

    convenience init(size: CGSize, pointView: UIView, items: [String],  handler: @escaping YYShotViewHandler) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: size))
        
        self.shotViewHandler = handler
        
        initViews(pointView: pointView, items: items)
        initPointX(pointView: pointView)
    }
    
    func initViews(pointView: UIView, items: [String] = []) {
        
        let pointViewFrame = pointView.convert(pointView.bounds, to: self.shotWindow)
        let x: CGFloat = UIScreen.main.bounds.width - YYShotView.shotViewW - space
        let y: CGFloat = pointViewFrame.origin.y + pointViewFrame.size.height
        self.frame = CGRect(x: x, y: y, width: self.frame.size.width, height: items.count.cgFloat * buttonH + self.triangleLength)
        self.shotWindow.addSubview(self)
        
        for (i, item) in items.enumerated() {
            let b = YYShotViewButton(title: item, tag: i, handler: {
                [weak self] tag in
                if let weakSelf = self {
                    weakSelf.shotViewHandler!(weakSelf.buttons[tag].titleLabel!.text!)
                    weakSelf.shotDismissWindow()
                }
            })
            b.mFrame = CGRect(x: 0, y: triangleLength + i.cgFloat * buttonH, width: self.frame.size.width, height: buttonH)
            self.addSubview(b)
            b.isShowLineView = (i != items.count - 1)
            self.buttons.append(b)
        }
    }
    
    func initPointX(pointView: UIView) {
        let centerRight = UIScreen.main.bounds.width - pointView.center.x
        self.pointX = YYShotView.shotViewW - centerRight + space / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let w: CGFloat = rect.size.width
        let h: CGFloat = rect.size.height

        let s: CGFloat = triangleLength
        let r: CGFloat = 3
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: r, y: s))
        context?.addLine(to: CGPoint(x: self.pointX, y: s))
        context?.addLine(to: CGPoint(x: self.pointX + s / 2, y: 0))
        context?.addLine(to: CGPoint(x: self.pointX + s, y: s))
        context?.addLine(to: CGPoint(x: w - r, y: s))
        context?.addQuadCurve(to: CGPoint(x: w, y: s + r), control: CGPoint(x: w, y: s))
        context?.addLine(to: CGPoint(x: w, y: h - r))
        context?.addQuadCurve(to: CGPoint(x: w - r, y: h), control: CGPoint(x: w, y: h))
        context?.addLine(to: CGPoint(x: r, y: h))
        context?.addQuadCurve(to: CGPoint(x: 0, y: h - r), control: CGPoint(x: 0, y: h))
        context?.addLine(to: CGPoint(x: 0, y: r + s))
        context?.addQuadCurve(to: CGPoint(x: r, y: s), control: CGPoint(x: 0, y: s))
        context?.setFillColor(UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1).cgColor)
        context!.drawPath(using: .fill)
    }
}
