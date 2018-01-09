//
//  YYWebView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/6/16.
//  Copyright © 2017年 侯佳男. All rights reserved.
//  WKWebView

import UIKit
import WebKit
import JavaScriptCore

class YYWebView: UIView {
    
    private let kEstimatedProgress = "estimatedProgress"
    weak var myDelegate: YYWebViewDelegate?
    
    var jsContext: JSContext!
    
    public var url: String!
    public var progressViewHeight: CGFloat = 2
    public var isShowProgress: Bool? {
        didSet {
            if isShowProgress! {
                self.addSubview(progressView)
                addObserver(webView, forKeyPath: kEstimatedProgress, options: .new, context: nil)
            }
        }
    }
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.frame = self.frame
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(self.url.ga_url!.ga_request!)
        return webView
    }()
    
    lazy var progressView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: progressViewHeight, width: self.webView.frame.size.width, height: progressViewHeight))
        v.backgroundColor = UIColor.blue
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, url: String) {
        self.init(frame: frame)
        
        self.url = url
        self.addSubview(webView)
        
    }
    
    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        if (keyPath == kEstimatedProgress) {
            progressView.frame = CGRect(x: 0, y: progressViewHeight, width: self.webView.frame.size.width * CGFloat(webView.estimatedProgress), height: progressViewHeight)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        guard let progress = isShowProgress else {
            return
        }
        if progress {
            removeObserver(webView, forKeyPath: kEstimatedProgress)
        }
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
        self.webView.frame = CGRect(origin: CGPoint.zero, size: self.webView.scrollView.contentSize)
        self.height = self.webView.frame.height
        self.myDelegate?.webViewDidFinish(self.height)
        
        js(webView, didFinish: navigation)
    }
    
    private func js(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.jsContext = webView.value(forKey: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        let model = jsModel()
        self.jsContext.setValue(model, forKey: "jsModel")
        model.jsContext = self.jsContext
        let curUrl = webView.url?.absoluteString    //WebView当前访问页面的链接 可动态注册
        self.jsContext.evaluateScript(curUrl)
        
        self.jsContext.exceptionHandler = { (context, exception) in
            print("exception：", exception ?? "--")
        }
    }
    
    // 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message, userContentController)
    }
    
}

class jsModel: jsDelegate {
    var jsContext: JSContext!
    
    func playLog(videoId: String) {
        print(videoId)
    }
    
    func existsCollectVideo(collectId:String, _ handleName:String, _ typeStr:String) {
        // 回调JS里定义的函数
        let handleFunc = self.jsContext.objectForKeyedSubscript(handleName)
        let dict = ["type": typeStr, "status": false] as [String : Any]
        let _ = handleFunc?.call(withArguments: [dict])
    }
}

@objc protocol jsDelegate: JSExport {
    func playLog(videoId:String)
     func existsCollectVideo(collectId:String, _ handleName:String, _ typeStr:String)
}

/*
 var existsCollectVideo = function() {
     if(window.YE) {
        window.YE.existsCollectVideo(albumId, "VideoCollectionHandle", "existsCollectVideo");
     }
 };
 
 var playLog = function(str) {
     if(window.YE) {
        window.YE.playLog(str);
     }
 };
 
 var VideoCollectionHandle = function(d) {
    alert(d.status);
 };
 
 existsCollectVideo();
 
 playLog("hello world");
 */