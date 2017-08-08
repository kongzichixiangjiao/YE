//
//  YYAlertViewController.swift
//  YeShi
//
//  Created by 侯佳男 on 2017/8/7.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit

enum YYAlertViewControllerType {
    case text, loading, imageAnimation, image_text, selected
}
enum YYAlertImageType: String {
    case success = "alert_success", error = "alert_error"
}

class YYAlertViewController: UIViewController {
    
    fileprivate var type: YYAlertViewControllerType!
    fileprivate var selfViewManager: YYSelfViewManager?
    fileprivate var dataSource: [String]!
    fileprivate var didSelectedHandler: DidSelectedHandler!
    
    fileprivate let fontSize: CGFloat = 12
    fileprivate let imageViewW: CGFloat = 40
    fileprivate let image_textToastViewW: CGFloat = 100
    
    lazy var alertWindow: YYWindow = {
        let alertWindow = YYWindow(frame: UIScreen.main.bounds)
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.backgroundColor = UIColor.clear
        alertWindow.becomeKey()
        alertWindow.makeKeyAndVisible()
        alertWindow.isHidden = false
        
        return alertWindow
    }()
    
    var toastView: UIView = {
        let v = UIView()
        v.frame = CGRect(origin: CGPoint.zero, size: CGSize.zero)
        v.backgroundColor = UIColor.darkGray
        v.alpha = 0.85
        v.layer.cornerRadius = 10
        
        return v
    }()
    
    lazy var textLabel: UILabel = {
        let v = UILabel()
        v.frame = CGRect(origin: CGPoint.zero, size: CGSize.zero)
        v.font = UIFont.systemFont(ofSize: self.fontSize)
        v.textColor = UIColor.white
        v.textAlignment = .center
        v.numberOfLines = 0
        v.backgroundColor = UIColor.clear
        
        return v
    }()
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        let w: CGFloat = self.imageViewW
        let x: CGFloat = self.toastView.frame.size.width / 2 - w / 2
        let y: CGFloat = self.toastView.frame.size.height / 2 - w + 10
        v.frame = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: w, height: w))
        return v
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let w: CGFloat = 20
        let v = UIActivityIndicatorView(activityIndicatorStyle: .white)
        v.startAnimating()
        v.frame = CGRect(origin: CGPoint(x: self.toastView.frame.width / 2 - w / 2, y: self.toastView.frame.height / 2 - w / 2), size: CGSize(width: w, height: w))
        return v
    }()
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = CGRect(x: 0, y: 0, width: self.alertWindow.bounds.size.width * 0.5, height: self.dataSource!.count.cgFloat * kYYAlertSelectedCellHeight)
        t.delegate = self
        t.dataSource = self
        t.isUserInteractionEnabled = true
        t.showsHorizontalScrollIndicator = false
        t.showsVerticalScrollIndicator = false
        t.separatorStyle = .none
        t.tableFooterView = UIView()
        
        t.clipStaticViewRectCorner(.bottomRight, cornerRadius: 10)
        
        t.register(UINib(nibName: kYYAlertSelectedCell, bundle: nil), forCellReuseIdentifier: kYYAlertSelectedCell)
        
        return t
    }()
    
    lazy var headerView: YYAlertSelectedTableViewHeaderView = {
        let headerView = Bundle.main.loadNibNamed("YYAlertSelectedTableViewHeaderView", owner: self, options: nil)?.last as! YYAlertSelectedTableViewHeaderView
        headerView.clipStaticViewRectCorner(.topLeft, cornerRadius: 5)
        headerView.closed.addTarget(self, action: #selector(closedAction), for: .touchUpInside)
        
        return headerView
    }()
    
    func closedAction() {
        removeViews()
        dismissAlertWindow()
    }
    
    public func yy_showText(text: String) {
        showText(text: text)
    }
    
    public func yy_showLoading() {
        showLoading()
    }
    
    public func yy_showImage_text(imageType: YYAlertImageType, text: String) {
        showImage_text(imageType: imageType, text: text)
    }
    
    public func yy_showSelected(title: String, data: [Any], handler: @escaping DidSelectedHandler) {
        showSelected(title: title, data: data, handler: handler)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOrientationNotification()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        print("--deinit--YYAlertViewController--")
    }
}

// MARK: show类型方法
extension YYAlertViewController {
    fileprivate func yy_show(type: YYAlertViewControllerType?) {
        self.type = type
        
        show()
    }
    
    private func show() {
        alertWindow.rootViewController = self
        
        setupSelfView()
    }
}

// MARK: 设置self.view
extension YYAlertViewController {
    fileprivate func setupSelfView() {
        self.view.backgroundColor = UIColor.clear
        if self.type != .selected {
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapViewAction(sender:)))
            self.view.addGestureRecognizer(tap)
        }
        
        guard let manager = self.selfViewManager else {
            return
        }
        self.view.backgroundColor = manager.backColor
        self.view.alpha = manager.alpha ?? self.view.alpha
        self.view.frame = manager.frame ?? self.view.frame
    }
    
    func tapViewAction(sender: UITapGestureRecognizer) {
        removeViews()
        dismissAlertWindow()
    }
}

// MARK: 监听屏幕方向
extension YYAlertViewController {
    fileprivate func addOrientationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(screenChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    func screenChange() {
        if UIScreen.main.bounds.width > UIScreen.main.bounds.height {
            print("横屏")
        } else {
            print("竖屏")
        }
        switch self.type! {
        case .text, .loading, .image_text:
            toastView.center = alertWindow.center
            break
        case .imageAnimation:
            break
        case .selected:
            tableView.center = alertWindow.center
            break
        }
    }
}
// MARK: 移除提醒
extension YYAlertViewController {
    fileprivate func removeViews() {
        switch self.type! {
        case .text:
            textLabel.removeFromSuperview()
            break
        case .loading:
            activity.stopAnimating()
            activity.removeFromSuperview()
            break
        case .image_text:
            textLabel.removeFromSuperview()
            imageView.removeFromSuperview()
            break
        case .imageAnimation:
            break
        case .selected:
            tableView.removeFromSuperview()
            break
        }
    }
    
    fileprivate func dismissAlertWindow() {
        alertWindow.resignKey()
        alertWindow.isHidden = true
        alertWindow.rootViewController = nil
    }
}
// MARK: 图文提醒
extension YYAlertViewController {
    fileprivate func showImage_text(imageType: YYAlertImageType, text: String) {
        yy_show(type: .image_text)
        
        showAnimation(view: toastView)
        showToastView(text: text)
        
        showImageView(imageType: imageType)
        
        showTextLabel(text: text, frame: CGRect(x: 0, y: image_textToastViewW / 2 + 20, width: toastView.bounds.width, height: 20))
    }
    
    fileprivate func showImageView(imageType: YYAlertImageType) {
        self.imageView.image = UIImage(named: imageType.rawValue)
        toastView.addSubview(self.imageView)
    }
}

// MARK: 文字提醒
extension YYAlertViewController {
    fileprivate func showText(text: String) {
        yy_show(type: .text)
        
        showAnimation(view: toastView)
        showToastView(text: text)
        
        showTextLabel(text: text, frame: toastView.bounds)
    }
    
    fileprivate func showTextLabel(text: String, frame: CGRect) {
        textLabel.text = text
        textLabel.frame = frame
        toastView.addSubview(textLabel)
    }
    
    fileprivate func heightWith(text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height)
    }
}

// MARK: loading提醒
extension YYAlertViewController {
    fileprivate func showLoading() {
        yy_show(type: .loading)
        
        showToastView(text: "")
        showAnimation(view: toastView)
        
        toastView.addSubview(activity)
    }
}

// MARK: SHOW toastView
extension YYAlertViewController {
    fileprivate func showToastView(text: String) {
        if self.type == .image_text {
            let space: CGFloat = 20
            let w: CGFloat = image_textToastViewW
            let x: CGFloat = alertWindow.bounds.width / 2 - w / 2
            let y: CGFloat = alertWindow.bounds.height / 2 - w / 2 + space
            self.toastView.frame = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: w, height: w))
            return
        }
        let space: CGFloat = 40
        let spaceW: CGFloat = 64
        let w: CGFloat = text == "" ? spaceW : UIScreen.main.bounds.width * 0.4 + space
        let h: CGFloat = text == "" ? spaceW : self.heightWith(text: text, fontSize: fontSize, width: w) + space
        let x: CGFloat = alertWindow.bounds.width / 2 - w / 2
        let y: CGFloat = alertWindow.bounds.height / 2 - h / 2
        self.toastView.frame = CGRect(origin: CGPoint(x: x, y: y), size: CGSize(width: w, height: h))
    }
}

// MARK: 动画方法
extension YYAlertViewController {
    fileprivate func showAnimation(view: UIView) {
        let basicAnimation          = CABasicAnimation(keyPath: KeyPath.scale.rawValue)
        basicAnimation.fromValue    = 0
        basicAnimation.toValue      = 0.8
        basicAnimation.autoreverses = false
        basicAnimation.duration     = 0.2
        view.layer.add(basicAnimation, forKey: "")
        
        alertWindow.addSubview(view)
    }
}

// MARK: SHOW 选择项
extension YYAlertViewController {
    fileprivate func showSelected(title: String, data: [Any], handler: DidSelectedHandler?) {
        yy_show(type: .selected)
        self.view.backgroundColor = UIColor.darkGray
        self.view.alpha = 0.4
        
        self.dataSource = data as! [String]
        self.didSelectedHandler = handler
        
        tableView.frame = CGRect(x: 0, y: 0, width: self.alertWindow.bounds.size.width * 0.5, height: CGFloat(data.count) * kYYAlertSelectedCellHeight)
        self.tableView.center = self.alertWindow.center
        alertWindow.addSubview(tableView)
        
        self.tableView.reloadData()
        
        alertWindow.addSubview(headerView)
        self.headerView.frame = CGRect(x: self.tableView.x, y: self.tableView.y - kYYAlertSelectedTableViewHeaderViewHeight, width: self.alertWindow.bounds.size.width * 0.5, height: kYYAlertSelectedTableViewHeaderViewHeight)
    }
}

// MARK: tableview代理
extension YYAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kYYAlertSelectedCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYAlertSelectedCell = tableView.dequeueReusableCell(withIdentifier: kYYAlertSelectedCell) as! YYAlertSelectedCell
        cell.myTitle = self.dataSource?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedHandler(indexPath.row, self.dataSource?[indexPath.row])
        removeViews()
        dismissAlertWindow()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension YYAlertViewController {
    // 支持屏幕旋转
    override var shouldAutorotate: Bool {
        return true
    }
    /*
     override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
     return .portrait
     }
     
     override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
     return .portrait
     }
     */
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .`default`
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
    
}
