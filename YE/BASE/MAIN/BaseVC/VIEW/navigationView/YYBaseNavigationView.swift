//
//  YYBaseNavigationView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum YYBaseNavigationViewRightButtonTyep: String {
    case service = "nav_service", finished = "finished", imSetting = "im_setting", normal = "normal", add = "nav_add", details = "im_details", mySetting = "my_setting"
}

@objc
protocol YYBaseNavigationViewProtocol: NSObjectProtocol {
    func back()
    func back(_ model: Any?)
    @objc optional
    func clickedNavigationViewRightButton(_ sender: UIButton)
    func clickedNavigationViewRightOtherButton(_ sender: UIButton)
}

class YYBaseNavigationView: YYBaseView {
    
    static let height: CGFloat = 64
    fileprivate let space: CGFloat = 10
    
    weak var myDelegate: YYBaseNavigationViewProtocol?
    
    open var myTitle: String? {
        didSet {
            self.titleLabel.text = myTitle
        }
    }
    
    open var isHiddenLeftButton: Bool? {
        didSet {
            self.backButton.isHidden = isHiddenLeftButton!
        }
    }
    
    open var isShowRightButton: Bool? {
        didSet {
            self.rightButton?.isHidden = !isShowRightButton!
        }
    }
    
    open var rightButtonIsEnabled: Bool! {
        didSet {
            self.rightButton?.isEnabled = rightButtonIsEnabled
        }
    }
    
    open var rightButtonState: UIControlState? {
        didSet {
            switch self.rightButtonType! {
            case .finished:
                self.rightButton!.isEnabled = !self.rightButton!.isEnabled
                break
            case .service:
                self.rightButton!.setImage(self.rightButton!.imageView?.image, for: rightButtonState!)
                break
            case .normal:
                break
            case .imSetting:
                break
            case .add:
                break
            case .details:
                break
            case .mySetting:
                break
            }
        }
    }
    
    open var leftButtonTitle: String? {
        didSet {
            self.backButton.setImage(UIImage(named: leftButtonTitle!), for: .normal)
        }
    }
    
    open var lineColor: UIColor = UIColor.lightGray
    open var isShowLine: Bool = true
    
    static let bW: CGFloat = 40
    static let bOtherW: CGFloat = 60
    static let bH: CGFloat = 40
    static let bImage: UIImage = UIImage(named: "nav_back")!
    
    lazy var backButton: UIButton = {
        let b = UIButton()
        b.frame = CGRect(x: 0, y: self.frame.size.height - YYBaseNavigationView.bH, width: YYBaseNavigationView.bW, height: YYBaseNavigationView.bH)
        b.setImage(YYBaseNavigationView.bImage, for: .normal)
        b.addTarget(self, action: #selector(YYBaseNavigationView.backAction(_:)), for: .touchUpInside)
        return b
    }()
    
    var rightButton: UIButton?
    var rightButtonType: YYBaseNavigationViewRightButtonTyep?
    
    @objc func rightButtonAction(_ sender: UIButton) {
        
        myDelegate?.clickedNavigationViewRightButton!(sender)
    }
    
    @objc func rightOtherButtonAction(_ sender: UIButton) {
        
        myDelegate?.clickedNavigationViewRightOtherButton(sender)
    }
    
    @objc func backAction(_ sender: UIButton) {
        myDelegate?.back()
        //        myDelegate?.back(nil)
    }
    
    lazy var titleLabel: UILabel = {
        let l = UILabel()
        let h: CGFloat = 15
        let y: CGFloat = self.backButton.center.y - 15 / 2
        l.frame = CGRect(x: 0, y: y, width: self.frame.size.width, height: h)
        l.textColor = UIColor.black
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 14)
        return l
    }()
    
    lazy var lineView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1 / UIScreen.main.scale))
        v.backgroundColor = self.lineColor
        self.addSubview(v)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        initView()
    }
    
    fileprivate func initView() {
        self.addSubview(backButton)
        self.addSubview(titleLabel)
        if (isShowLine) {
            self.addSubview(lineView)
        }
    }
    
    func setupRightButton(_ type: YYBaseNavigationViewRightButtonTyep) {
        self.rightButtonType = type
        
        var b: UIButton
        switch type {
        case .finished:
            b = "YYBaseNavigationViewTextButton".xibLoadView() as! UIButton
            b.isEnabled = false
            break
        case .service:
            b = "YYBaseNavigationViewServiceButton".xibLoadView() as! UIButton
            break
        case .imSetting:
            b = "YYBaseNavigationViewImageButton".xibLoadView() as! UIButton
            b.setImage(UIImage(named: type.rawValue), for: .normal)
            break
        case .normal:
            b = "YYBaseNavigationViewImageButton".xibLoadView() as! UIButton
            break
        case .add:
            b = "YYBaseNavigationViewImageButton".xibLoadView() as! UIButton
            b.setImage(UIImage(named: type.rawValue), for: .normal)
            break
        case .details:
            b = "YYBaseNavigationViewImageButton".xibLoadView() as! UIButton
            b.setImage(UIImage(named: type.rawValue), for: .normal)
            break
        case .mySetting:
            b = "YYBaseNavigationViewImageButton".xibLoadView() as! UIButton
            b.setImage(UIImage(named: type.rawValue), for: .normal)
            break
        }
        b.frame = CGRect(x: self.frame.size.width - YYBaseNavigationView.bW - space, y: self.frame.size.height - YYBaseNavigationView.bH, width: YYBaseNavigationView.bW, height: YYBaseNavigationView.bH)
        b.addTarget(self, action: #selector(rightButtonAction(_:)), for: .touchUpInside)
        self.addSubview(b)
        
        self.rightButton = b
    }
    
    func setupOtherRightButton(title: String) {
        let b = UIButton()
        b.frame = CGRect(x: self.frame.size.width - YYBaseNavigationView.bW*2 - space*2 , y: self.frame.size.height - YYBaseNavigationView.bH, width: YYBaseNavigationView.bOtherW, height: YYBaseNavigationView.bH)
        b.setTitle(title, for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        b.addTarget(self, action: #selector(rightOtherButtonAction(_:)), for: .touchUpInside)
        self.addSubview(b)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
