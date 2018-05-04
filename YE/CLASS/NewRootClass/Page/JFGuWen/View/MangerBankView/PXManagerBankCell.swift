//
//  PXManagerBankCell.swift
//  YE
//
//  Created by 侯佳男 on 2018/5/4.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

enum PXManagerBankType: Int {
    case setDefault = 0, edit = 1, delete = 2
}

class PXManagerBankCell: UICollectionViewCell {

    static let identifier = "PXManagerBankCell"
    
    public typealias ScrollDidselectedHandler = (_ : Int, _ : Any?) -> ()
    public var scrollDidselectedHandler: ScrollDidselectedHandler?
    
    public typealias ClickedHandler = (_ : PXManagerBankType, _ : Any?) -> ()
    public var clickedHandler: ClickedHandler?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var myContentView: UIView!
    @IBOutlet weak var contentSizeWidth: NSLayoutConstraint!
    @IBOutlet weak var setDefaultButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var bankLogoImageView: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var bankDressLabel: UILabel!
    @IBOutlet weak var bankCardLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var defaultImageView: UIImageView!
    
    var myRow: Int = -1
    var isAllowEdit: Bool = true
    var buttons: [UIButton] = []
    
    var model: Any! {
        didSet {
            if (myRow == 0) {
                self.setDefaultButton.backgroundColor = UIColor.lightGray // dadada
                self.setDefaultButton.setTitleColor(UIColor.white, for: .normal)
                self.deleteButton.backgroundColor = UIColor.lightGray // dadada
                self.deleteButton.setTitleColor(UIColor.white, for: .normal)
                self.editButton.backgroundColor = UIColor.lightGray // dadada
                self.editButton.setTitleColor(UIColor.white, for: .normal)
                self.defaultImageView.isHidden = true
            } else {
//                self.setDefaultButton.backgroundColor = UIColor.lightGray // dadada
//                self.setDefaultButton.setTitleColor(UIColor.white, for: .normal)
//                self.deleteButton.backgroundColor = UIColor.lightGray // dadada
//                self.deleteButton.setTitleColor(UIColor.white, for: .normal)
//                self.editButton.backgroundColor = UIColor.lightGray // dadada
//                self.editButton.setTitleColor(UIColor.white, for: .normal)
                self.defaultImageView.isHidden = true
            }
        }
    }
    
    @IBAction func setDefaultAction(_ sender: UIButton) {
        
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        
    }
    
    @objc func tapMyContentView(_ sender: UITapGestureRecognizer) {
        self.scrollDidselectedHandler!(self.myRow, nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        buttons.append(setDefaultButton)
        buttons.append(editButton)
        buttons.append(deleteButton)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyContentView(_:)))
        tap.delegate = self
        contentView.addGestureRecognizer(tap)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentSizeWidth.constant = MainScreenWidth + 125
    }

    lazy var myWindow: UIWindow? = {
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.backgroundColor = UIColor.blue
        alertWindow.alpha = 0.3
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyWindow(_:)))
        alertWindow.addGestureRecognizer(tap)
        
        return alertWindow
    }()
    
    lazy var mMaskView: UIView? = {
        guard let win = UIApplication.shared.windows.first else {
            return nil
        }
        let v = UIView(frame: win.bounds)
        v.backgroundColor = UIColor.clear
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMyWindow(_:)))
        tap.delegate = self
        v.addGestureRecognizer(tap)
        
        win.addSubview(v)
        return v
    }()
    
    @objc func tapMyWindow(_ sender: UITapGestureRecognizer) {
        removeMaskView()
    }
    
    func dissmissWhiteWindow() {
        mMaskView?.isHidden = true
        return
    }
    
    func showWhiteWindow() {
        mMaskView?.isHidden = false
        return
    }
    
    private func removeMaskView() {
        dissmissWhiteWindow()
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint.zero
        }
    }
}

extension PXManagerBankCell: UIGestureRecognizerDelegate {
    
    override open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let point = gestureRecognizer.location(in: nil)
        var frames: [CGRect] = []
        for b in self.buttons {
            let frame = b.convert(b.bounds, to: nil)
            frames.append(frame)
        }
        
        if (scrollView.contentOffset.x != 0) {
            removeMaskView()
            
            for (index, frame) in frames.enumerated() {
                if frame.contains(point) {
                    if (myRow != 0) {
                        self.clickedHandler!(PXManagerBankType(rawValue: index)!, buttons[index].titleLabel?.text)
                    }
                    return false
                }
            }
        }
        
        return true
    }
}

extension PXManagerBankCell {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (!isAllowEdit) {
            return 
        }
        if (scrollView.contentOffset.x != 0) {
            showWhiteWindow()
        }
    }
}
