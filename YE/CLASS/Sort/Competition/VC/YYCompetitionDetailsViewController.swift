//
//  YYCompetitionDetailsViewController.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import WebKit

class YYCompetitionDetailsViewController: YYBaseTableViewController {
    
    var isDecelerating: Bool = false
    
    var bottomView: YYCompetitionDetailsBottomView!
    
    lazy var webView: YYWebView = {
        let webView = YYWebView(frame: CGRect(x: 0, y: 0, width: MainScreenWidth, height: 200), url: "https://www.sina.com")
        webView.myDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTitle = "活动详情"
        
        initTableView()
        
        self.webView.show()
        
        initData()
        
        initBottomView()
    }
    
    func initBottomView()  {
        self.bottomView = YYCompetitionDetailsBottomView.ga_loadView() as! YYCompetitionDetailsBottomView
        self.bottomView.myDelegate = self;
        self.bottomView.frame = CGRect(x: 0, y: MainScreenHeight - YYCompetitionDetailsBottomView.height - TabBarHeight, width: MainScreenWidth, height: YYCompetitionDetailsBottomView.height)
        self.view.addSubview(self.bottomView)
    }
    
    func initData() {
        
        let path = Bundle.ga_path("comment.plist")
        let data: [[String : Any]] = NSArray.init(contentsOfFile: path) as! [[String : Any]]
        self.dataSource = YYCompetitionCommentSectionModel.getModels(data)
        tableView.reloadData()
    }
    
    override func initTableView() {
        saveAreaBottomSpaceType = .normal44
        registerNibWithIdentifier(YYCompetitionCommentCell.identifier)
        tableView.tableHeaderView = initTableViewHeaderView()
    }
    
    func initTableViewHeaderView() -> YYCompetitionDetailsHeaderView {
        let header = Bundle.main.loadNibNamed("YYCompetitionDetailsHeaderView", owner: self, options: nil)?.last as! YYCompetitionDetailsHeaderView
        header.frame = CGRect(x: 0, y: 0, width: MainScreenWidth, height: YYCompetitionDetailsHeaderView.height)
        return header
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //添加监听键盘的通知
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillShowKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleWillHideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
}


// MARK: 监听键盘
extension YYCompetitionDetailsViewController {
    @objc func handleWillShowKeyboard(notification: NSNotification) {
        
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        let v : NSValue = userInfo.object(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        
        let beginRect: CGRect = v.cgRectValue
        
        let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
        
        UIView.animate(withDuration: 0.3, delay: 0, options: options, animations: { 
            self.bottomView.frame = CGRect(x: 0, y: MainScreenHeight - beginRect.height - YYCompetitionDetailsBottomView.height, width: MainScreenWidth, height: YYCompetitionDetailsBottomView.height)
        }, completion: nil)
    }
    
    @objc func handleWillHideKeyboard(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        
        let v : NSValue = userInfo.object(forKey: UIKeyboardFrameBeginUserInfoKey) as! NSValue
        
        let _: CGRect = v.cgRectValue
        UIView.animate(withDuration: 0.3) {
            self.bottomView.showBottomView()
        }
    }
}

extension YYCompetitionDetailsViewController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging")
        self.bottomView.hideBottomView()
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        self.isDecelerating = true
        print("scrollViewWillBeginDecelerating")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if (!self.isDecelerating) {
            self.bottomView.showBottomView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        if (self.isDecelerating) {
            self.bottomView.showBottomView()
        }
        self.isDecelerating = false
    }
}

extension YYCompetitionDetailsViewController: YYWebViewDelegate {
    func webViewDidFinish(_ height: CGFloat) {
        tableView.tableFooterView = self.webView
    }
}

extension YYCompetitionDetailsViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YYCompetitionCommentCell = tableView.dequeueReusableCell(withIdentifier: YYCompetitionCommentCell.identifier) as! YYCompetitionCommentCell
        cell.model = self.dataSource[indexPath.row] as! YYCompetitionCommentSectionModel
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.dataSource[indexPath.row] as! YYCompetitionCommentSectionModel).replyHeight
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = Bundle.main.loadNibNamed("YYCompetitionCommentSectionView", owner: self, options: nil)?.last as! YYCompetitionCommentSectionView
        let model: YYCompetitionCommentSectionModel = self.dataSource[section] as! YYCompetitionCommentSectionModel
        v.model = model
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let model: YYCompetitionCommentSectionModel = self.dataSource[section] as! YYCompetitionCommentSectionModel
        return model.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

extension YYCompetitionDetailsViewController: YYCompetitionDetailsBottomViewDelegate {
    func applyQuery(_ id: String) {
        self.push(YYApplyQueryViewController())
    }
    
    func apply(_ id: String){
        let vc = YYApplyViewController()
        vc.myType = .apply
        self.push(vc)
    }
}
