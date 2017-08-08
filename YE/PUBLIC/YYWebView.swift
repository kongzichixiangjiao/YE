//
//  YYWebView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  WKWebView

import UIKit
import WebKit

class YYWebView: UIView {
    
    weak var myDelegate: YYWebViewDelegate?
    
    var url: String!
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.frame = self.frame
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(self.url.ga_url!.ga_request!)
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, url: String) {
        self.init(frame: frame)
        
        self.url = url
        self.addSubview(webView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
    
}

extension YYWebView: WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    // 开始加载时
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    // 内容开始返回时
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    // 页面加载完成时
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish")
        self.webView.frame = CGRect(origin: CGPoint.zero, size: self.webView.scrollView.contentSize)
        self.height = self.webView.frame.height
        self.myDelegate?.webViewDidFinish(height: self.height)
    }
    // 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message, userContentController)
    }
    
}

