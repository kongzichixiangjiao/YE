//
//  YYAlertBirthdayView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

protocol BirthdayProtocol {
    var birthdayView: YYAlertBirthdayView { set get }
}

extension UIView: BirthdayProtocol {
    var birthdayView: YYAlertBirthdayView {
        get {
            guard let b: YYAlertBirthdayView = objc_getAssociatedObject(self, &YYAlertKey.kBirthdayView) as? YYAlertBirthdayView else {
                let birthdayView = Bundle.main.loadNibNamed("YYAlertBirthdayView", owner: self, options: nil)?.last as! YYAlertBirthdayView
                birthdayView.frame = CGRect(x: 0, y: MainScreenHeight, width: MainScreenWidth, height: YYAlertBirthdayView.height)
                birthdayView.myDelegate = self
                objc_setAssociatedObject(self, &YYAlertKey.kBirthdayView, birthdayView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return birthdayView
            }
            return b
        }
        set {
            
        }
    }
    
    func showBirthdayView(handler: @escaping DidSelectedHandler) {
        self.alertWindow.addSubview(self.birthdayView)
        UIView.animate(withDuration: 0.25) {
            self.birthdayView.frame = CGRect(x: 0, y: MainScreenHeight - YYAlertBirthdayView.height, width: MainScreenWidth, height: YYAlertBirthdayView.height)
        }
        
        self.didSelectedHandler = handler
        objc_setAssociatedObject(self, &YYAlertKey.kDidSelectedHandler, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func hideBirthdayView() {
        UIView.animate(withDuration: 0.25, animations: { 
            self.birthdayView.frame = CGRect(x: 0, y: MainScreenHeight, width: MainScreenWidth, height: YYAlertBirthdayView.height)
        }) { (bo) in
            objc_setAssociatedObject(self, &YYAlertKey.kBirthdayView, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &YYAlertKey.kDidSelectedHandler, nil, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIView: YYAlertBirthdayViewDelegate {
    func cancle() {
        ga_dissmissBlackWindow()
    }
    
    func value(date: Date) {
        self.didSelectedHandler!(9999, date)
        ga_dissmissBlackWindow()
    }
}

protocol YYAlertBirthdayViewDelegate: NSObjectProtocol {
    func cancle()
    func value(date: Date)
}

class YYAlertBirthdayView: UIView {
    static var height: CGFloat = 260
    
    weak var myDelegate: YYAlertBirthdayViewDelegate?
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancleButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBAction func cancleAction(_ sender: UIButton) {
        myDelegate?.cancle()
    }
    
    @IBAction func confirmAction(_ sender: UIButton) {
        myDelegate?.value(date: self.datePicker.date)
    }
    
    @IBAction func valueChangedAction(_ sender: UIDatePicker) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
