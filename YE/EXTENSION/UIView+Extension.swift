//
//  UIViewExtension.swift
//  GA_ReloadSection
//
//  Created by houjianan on 16/8/5.
//  Copyright © 2016年 houjianan. All rights reserved.
//
import UIKit

extension UIView {
    
    public class func xibViewFrom<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    public class func xibView() -> Self {
        return xibViewFrom(viewType: self)
    }
}


// MARK:  裁剪 view 的圆角
extension UIView {
    // 可以滚动的视图不能用这个方法
    func clipStaticViewRectCorner(_ direction: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: direction, cornerRadii: cornerSize)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.addSublayer(maskLayer)
        layer.mask = maskLayer
    }
    
    func clipRectCorner(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func strokeBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}

// MARK: width  height  x  y
extension UIView {
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x    = newValue
            frame                 = tempFrame
        }
    }
    
    /// y
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y    = newValue
            frame                 = tempFrame
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame                 = tempFrame
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter;
        }
    }
    
    var maxY: CGFloat {
        get {
            return height + y
        }
    }
    
    var maxX: CGFloat {
        get {
            return width + x
        }
    }
    
}


// MARK: Bundle.main.loadNibNamed
extension UIView {
    class func ga_loadView() -> UIView {
        return Bundle.main.loadNibNamed(self.ga_nameOfClass, owner: self, options: nil)?.last as! UIView
    }
}

// MARK: Xib 属性设置
protocol UIViewExtensionProtocol {
    
    var ga_cornerRadius: CGFloat {get set}
    
    var ga_masksToBounds: Bool {get set}
    
    var ga_borderWidth: CGFloat {get set}
    var ga_borderColor: UIColor {get set}
    
    var ga_shadowColor: UIColor {get set}
    var ga_shadowOpacity: CGFloat {get set}
    var ga_shadowOffset: CGSize {get set}
    var ga_shadowRadius: CGFloat {get set}
    
}

extension UIView: UIViewExtensionProtocol {
    @IBInspectable var ga_cornerRadius: CGFloat {
        get {
            return  self.ga_cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var ga_borderWidth: CGFloat {
        get {
            return self.ga_borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var ga_masksToBounds: Bool {
        get {
            return self.ga_masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    @IBInspectable var ga_borderColor: UIColor {
        get {
            return self.ga_borderColor
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var ga_shadowColor: UIColor {
        get {
            return self.ga_shadowColor
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var ga_shadowOpacity: CGFloat {
        get {
            return self.ga_shadowOpacity
        }
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
    }
    
    @IBInspectable var ga_shadowOffset: CGSize {
        get {
            return self.ga_shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var ga_shadowRadius: CGFloat {
        get {
            return self.ga_shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
}

// MARK: 1、分割线设置  2、show()
enum LineViewPosition {
    case top, bottom, left, right
}

extension UIView {
    
    func showLineView(space: CGFloat, position: LineViewPosition = .bottom, color: UIColor = UIColor.lightGray) {
        if let _ = objc_getAssociatedObject(self, "lineView") {
            return
        }
        let h = 1.0 / UIScreen.main.scale
        
        let lineView = UIView(frame: CGRect(x: space, y: position == .top ? 0 : self.frame.size.height - 1, width: self.frame.size.width - space * 2, height: h))
        lineView.backgroundColor = color 
        self.addSubview(lineView)
        
        objc_setAssociatedObject(self, "lineView", lineView, .OBJC_ASSOCIATION_RETAIN)
    }
    
    func clickCircle() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func show() {
        #if DEBUG
        print(self)
        #endif
    }
    
}
