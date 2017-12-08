//
//  YYBaseViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYBaseViewController: UIViewController {
 
    var isShowNavigationView: Bool = false
    
    var kNavigationViewBottomSpace: CGFloat = 0
    
    var myTitle: String? {
        didSet {
            navigationView.myTitle = myTitle
            self.title = myTitle
        }
    }
    
    var isShowRightButton: Bool? {
        didSet {
            navigationView.isShowRightButton = isShowRightButton
        }
    }
    
    var rightButtonState: UIControlState? {
        didSet {
            navigationView.rightButtonState = rightButtonState!
        }
    }
    
    var rightButtonIsEnabled: Bool! {
        didSet {
            navigationView.rightButtonIsEnabled = rightButtonIsEnabled
        }
    }
    
    var isHiddenLeftButton: Bool? {
        didSet {
            navigationView.isHiddenLeftButton = isHiddenLeftButton
        }
    }
    
    var leftButtonTitle: String? {
        didSet {
            self.navigationView.backButton.setImage(UIImage(named: leftButtonTitle!), for: .normal)
        }
    }
    
    var kNavigationBarMaxY: CGFloat {
        return self.navigationView.frame.size.height + self.navigationView.frame.origin.y
    }
    
    lazy var navigationView: YYBaseNavigationView = {
        var insets = UIEdgeInsets.zero
        var height: CGFloat = 64
        if UIDevice.current.isX {
            if #available(iOS 11.0, *) { // 多余
                insets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
                height -= kNavigationViewBottomSpace
            }
        }
        let v = YYBaseNavigationView(frame: CGRect(x: 0, y: insets.bottom, width: self.view.frame.size.width, height: height))
        v.myDelegate = self
        self.view.addSubview(v)
        
        self.isShowNavigationView = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
//        addDeviceOrientationNotification()
    }
    
    func addDeviceOrientationNotification() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    open func initNavigationView(_ title: String, _ isHiddenLeftButton: Bool = false) {
        navigationView.myTitle = "首页"
        navigationView.isHiddenLeftButton = isHiddenLeftButton
    }
    
    open func setupRightButton(_ type: YYBaseNavigationViewRightButtonTyep) {
        navigationView.setupRightButton(type)
    }
    
    open func setupOtherRightButton() {
        navigationView.setupOtherRightButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    open func push(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    open func pop(_ vc: UIViewController) {
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    open func popRoot() {
        self.navigationController?.popToRootViewController(animated: true);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear -- ", self.ga_nameOfClass)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear -- ", self.ga_nameOfClass)
    }
    
    deinit {
        print("deinit -- ", self.ga_nameOfClass)
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    func clickedLeftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickedRightButtonAction(_ sender: UIButton) {
        
    }
    
    func clickedNavigationViewOtherRightButton(_ sender: UIButton) {
        
    }
    
    // 屏幕旋转监听
    func orientationChanged(){
        switch UIDevice.current.orientation {
        case .faceDown:
            print(UIDevice.current.orientation)
            break
        case .faceUp:
            print(UIDevice.current.orientation)
            break
        case .landscapeLeft:
            print(UIDevice.current.orientation)
            break
        case .landscapeRight:
            print(UIDevice.current.orientation)
            break
        case .portrait:
            // shu'ping
            print(UIDevice.current.orientation)
            break
        case .portraitUpsideDown:
            print(UIDevice.current.orientation)
            break
        case .unknown:
            print(UIDevice.current.orientation)
            break
        }
    }
 
}


extension YYBaseViewController: YYBaseNavigationViewProtocol {
    func clickedNavigationViewRightOtherButton(_ sender: UIButton) {
        clickedNavigationViewOtherRightButton(sender)
    }
    
    func back() {
        self.clickedLeftButtonAction()
    }
    
    func back(_ model: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickedNavigationViewRightButton(_ sender: UIButton) {
        clickedRightButtonAction(sender)
    }
}

extension YYBaseViewController {
    @objc func handleDeviceOrientationDidChange() {
        orientationChanged()
    }
    
//    override var shouldAutorotate: Bool {
//        return false
//    }
    
//    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
//        _ = super.supportedInterfaceOrientations
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            return .landscape
//        }else {
//            return .portrait
//        }
//    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.fade
    }

    
}

