//
//  YYBaseViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/19.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

class YYBaseViewController: UIViewController {

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
    
    lazy var navigationView: YYBaseNavigationView = {
        let v = YYBaseNavigationView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 64))
        v.myDelegate = self
        self.view.addSubview(v)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
    }
    
    
    public func initNavigationView(_ title: String, _ isHiddenLeftButton: Bool = false) {
        navigationView.myTitle = "首页"
        navigationView.isHiddenLeftButton = isHiddenLeftButton
    }
    
    public func setupRightButton(type: YYBaseNavigationViewRightButtonTyep) {
        navigationView.setupRightButton(type: type)
    }
    
    public func setupOtherRightButton() {
        navigationView.setupOtherRightButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func push(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }

    public func pop(vc: UIViewController) {
        self.navigationController?.popToViewController(vc, animated: true)
    }
    
    public func popRoot() {
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
    }
    
    func clickedLeftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickedRightButtonAction(sender: UIButton) {
        
    }
    
    func clickedNavigationViewOtherRightButton(sender: UIButton) {
        
    }
    
}


extension YYBaseViewController: YYBaseNavigationViewProtocol {
    func back() {
        self.clickedLeftButtonAction()
    }

    func back(_ model: Any?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func clickedNavigationViewRightButton(sender: UIButton) {
        clickedRightButtonAction(sender: sender)
    }
}
