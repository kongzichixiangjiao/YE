//
//  YYAttributeTextTapForSwfit.swift
//  YYAttributeTextTapForSwfit
//
//  Created by 侯佳男 on 2017/6/15.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

public var kAttributeStrings: UInt = 99000

private var isTapAction : Bool?

private var tapBlock : ((_ row: Int, _ str : String ,_ range : NSRange ,_ index : Int) -> Void)?
private var isTapEffect : Bool = true
private var effectDic : Dictionary<String , NSAttributedString>?

/*
 <#label#>.yy_addAttributeTapAction(self.myRow, [reply.from, reply.to]) { (row, string, range, int) in
    print("点击了\(string)标签 - {\(range.location) , \(range.length)} - \(int)")
 }
*/

extension UILabel {
    
    var attributeStrings : [YYAttributeModel]? {
        get {
            return objc_getAssociatedObject(self, &kAttributeStrings) as? [YYAttributeModel]
        }
        set {
            objc_setAssociatedObject(self, &kAttributeStrings, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Objects
    /// 是否打开点击效果，默认是打开
    var enabledTapEffect : Bool {
        set {
            isTapEffect = newValue
        }
        get {
            return isTapEffect
        }
    }
    
    
    // MARK: - mainFunction
    /**
     给文本添加点击事件
     
     - parameter strings:   需要点击的字符串数组
     - parameter tapAction: 点击事件回调
     */
    public func yy_addAttributeTapAction(_ row: Int, _ strings : [String] , tapAction : @escaping ((Int, String , NSRange , Int) -> Void)) -> Void {
        
        yy_getRange(row, strings)
        
        tapBlock = tapAction

    }
    
    // MARK: - touchActions
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTapAction == false {
            return
        }
        
        let touch = touches.first
        
        let point = touch?.location(in: self)
        
        yy_getTapFrame(point!) { (String, NSRange, Int) -> Void in
            
            if tapBlock != nil {
                tapBlock! (Int, String, NSRange , Int)
            }
            
            if (isTapEffect && NSRange.location != NSNotFound) {
                self.yy_saveEffectDicWithRange(NSRange)
                self.yy_tapEffectWithStatus(true)
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTapEffect {
            self.performSelector(onMainThread: #selector(self.yy_tapEffectWithStatus(_:)), with: nil, waitUntilDone: false)
        }
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTapEffect {
            self.performSelector(onMainThread: #selector(self.yy_tapEffectWithStatus(_:)), with: nil, waitUntilDone: false)
        }
    }
    
    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isTapAction == true {
            
            let result = yy_getTapFrame(point, result: { (
                String, NSRange, Int) -> Void in
                
            })
            
            if result == true {
                return self
            }
        }
        return super.hitTest(point, with: event)
    }
    
    // MARK: - getTapFrame
    @discardableResult
    fileprivate func yy_getTapFrame(_ point : CGPoint , result : ((_ str : String ,_ range : NSRange ,_ index : Int) -> Void)) -> Bool {
        
        let framesetter = CTFramesetterCreateWithAttributedString(self.attributedText!)
        
        var path = CGMutablePath()
        
        path.addRect(self.bounds, transform: CGAffineTransform.identity)
        
        var frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        
        let range = CTFrameGetVisibleStringRange(frame)
        
        if self.attributedText?.length > range.length {
            var m_font : UIFont
            let n_font = self.attributedText?.attribute(NSAttributedStringKey.font, at: 0, effectiveRange: nil)
            if n_font != nil {
                m_font = n_font as! UIFont
            }else if (self.font != nil) {
                m_font = self.font
            }else {
                m_font = UIFont.systemFont(ofSize: 17)
            }
            
            path = CGMutablePath()
            path.addRect(CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height + m_font.lineHeight), transform: CGAffineTransform.identity)
            
            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        }
        
        let lines = CTFrameGetLines(frame)
        
        if lines == [] as CFArray {
            return false
        }
        
        let count = CFArrayGetCount(lines)
        
        var origins = [CGPoint](repeating: CGPoint.zero, count: count)
        
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &origins)
        
        let transform = CGAffineTransform(translationX: 0, y: self.bounds.size.height).scaledBy(x: 1.0, y: -1.0);
        
        let verticalOffset = 0.0
        
        for i : CFIndex in 0..<count {
            
            let linePoint = origins[i]
            
            let line = CFArrayGetValueAtIndex(lines, i)
            
            let lineRef = unsafeBitCast(line,to: CTLine.self)
            
            let flippedRect : CGRect = yy_getLineBounds(lineRef , point: linePoint)
            
            var rect = flippedRect.applying(transform)
            
            rect = rect.insetBy(dx: 0, dy: 0)
            
            rect = rect.offsetBy(dx: 0, dy: CGFloat(verticalOffset))
            
            let style = self.attributedText?.attribute(NSAttributedStringKey.paragraphStyle, at: 0, effectiveRange: nil)
            
            var lineSpace : CGFloat = 0.0
            
            if (style != nil) {
                lineSpace = (style as! NSParagraphStyle).lineSpacing
            }else {
                lineSpace = 0.0
            }
            
            let lineOutSpace = (CGFloat(self.bounds.size.height) - CGFloat(lineSpace) * CGFloat(count - 1) - CGFloat(rect.size.height) * CGFloat(count)) / 2
            
            rect.origin.y = lineOutSpace + rect.size.height * CGFloat(i) + lineSpace * CGFloat(i)
            
            if rect.contains(point) {
                
                let relativePoint = CGPoint(x: point.x - rect.minX, y: point.y - rect.minY)
                
                var index = CTLineGetStringIndexForPosition(lineRef, relativePoint)
                
                var offset : CGFloat = 0.0
                
                CTLineGetOffsetForStringIndex(lineRef, index, &offset)
                
                if offset > relativePoint.x {
                    index = index - 1
                }
                
                guard let attributeStrings = attributeStrings else {
                    return false
                }
                let link_count = attributeStrings.count
                
                for j in 0 ..< link_count {
                    
                    let model = attributeStrings[j]

                    let link_range = model.range

                    if NSLocationInRange(index, link_range!) {

                        result(model.str!,model.range!,j)
                        
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    fileprivate func yy_getLineBounds(_ line : CTLine , point : CGPoint) -> CGRect {
        var ascent : CGFloat = 0.0;
        var descent : CGFloat = 0.0;
        var leading  : CGFloat = 0.0;
        
        let width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
        
        let height = ascent + fabs(descent) + leading
        
        return CGRect.init(x: point.x, y: point.y , width: CGFloat(width), height: height)
    }
    
    // MARK: - getRange
    fileprivate func yy_getRange(_ row: Int, _ strings :  [String]) -> Void {
        
        if self.attributedText?.length == 0 {
            return;
        }
        
        self.isUserInteractionEnabled = true
        
        isTapAction = true
        
        var totalString = self.attributedText?.string
        
            attributeStrings = [];
        
        for str : String in strings {
            let range = totalString?.range(of: str)
            if (range?.lowerBound != nil) {
                
                totalString = totalString?.replacingCharacters(in: range!, with: self.yy_getString(str.count))
                
                let model = YYAttributeModel()
                
                model.range = totalString?.nsRange(from: range!)
                model.str = str
                model.row = row
                
                attributeStrings?.append(model)
            }
        }
    }
    
    fileprivate func yy_getString(_ count : Int) -> String {
        var string = ""
        for _ in 0 ..< count {
            string = string + " "
        }
        return string
    }
    
    // MARK: - tapEffect
    fileprivate func yy_saveEffectDicWithRange(_ range : NSRange) -> Void {
        effectDic = [:]
        
        let subAttribute = self.attributedText?.attributedSubstring(from: range)
        
        _ = effectDic?.updateValue(subAttribute!, forKey: NSStringFromRange(range))
    }
    
    @objc fileprivate func yy_tapEffectWithStatus(_ status : Bool) -> Void {
        if isTapEffect {
            guard let _ = effectDic else {
                return
            }
            let attStr = NSMutableAttributedString.init(attributedString: self.attributedText!)
            
            let subAtt = NSMutableAttributedString.init(attributedString: (effectDic?.values.first)!)
            
            let range = NSRangeFromString(effectDic!.keys.first!)
            
            if status {
                subAtt.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.lightGray, range: NSMakeRange(0, subAtt.length))
                attStr.replaceCharacters(in: range, with: subAtt)
            }else {
                attStr.replaceCharacters(in: range, with: subAtt)
            }
            self.attributedText = attStr
        }
    }
}

class YYAttributeModel: Any {
    
    var range : NSRange?
    var str : String?
    var row: Int?
}

private extension String {
    
    func nsRange(from range: Range<String.Index>) -> NSRange {
        _ = range.lowerBound.samePosition(in: self)
        _ = range.upperBound.samePosition(in: self)
//        let loc =
        
        return NSMakeRange(0, 0)
    }
    

//    func nsRange(from range: Range<String.Index>) -> NSRange {
//        let from = range.lowerBound.samePosition(in: utf16)
//        let to = range.upperBound.samePosition(in: utf16)
//        let rangeFrom = utf16.distance(from: utf16.startIndex, to: from)
//        let rangeTo = utf16.distance(from: from, to: to)
//        return NSMakeRange(utf16.index, rangeTo)
//        return NSMakeRange(rangeFrom, rangeTo)
//        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),length: utf16.distance(from: from, to: to))
//    }
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
