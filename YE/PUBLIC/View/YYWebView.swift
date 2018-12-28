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
    private let kWebViewTitle = "title"
    private let kJS_Name = "AppModel"
    
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
    
    func jsAAA() {
        webView.evaluateJavaScript("") { (obj, error) in

        }
    }
    
    lazy var configuration: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration()
        // 设置偏好设置
        config.preferences = WKPreferences()
        // 默认为0
        config.preferences.minimumFontSize = 10
        // 默认认为YES
        config.preferences.javaScriptEnabled = true
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        // web内容处理池
        //         config.processPool = WKProcessPool()
        config.userContentController = self.userContentController
        // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
        config.userContentController.add(self, name: kJS_Name)
        return config
    }()
    
    // 通过JS与webview内容交互
    lazy var userContentController: WKUserContentController = {
        let c = WKUserContentController()
        return c
    }()
    
    lazy var webView: WKWebView = {
        
        self.addCooie()
        self.addJS()
        
        let webView = WKWebView(frame: self.frame, configuration: self.configuration)
        // 开启侧边手势
        webView.allowsBackForwardNavigationGestures = true
        // 3DTouch
        webView.allowsLinkPreview = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.addSubview(webView)
        return webView
    }()
    
    private func addCooie() {
        let s = WKUserScript(source: "document.cookie = 'DarkAngelCookie=DarkAngel;'", injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        self.userContentController.addUserScript(s)
    }
    
    private func addJS() {
        /*
         注入的js source可以是任何js字符串，也可以js文件。比如你有很多提供给h5使用的js方法，那么你本地可能就会有一个native_functions.js，你可以通过以下的方式添加
         //防止频繁IO操作，造成性能影响
         static NSString *jsSource;
         static dispatch_once_t onceToken;
         dispatch_once(&onceToken, ^{
         jsSource = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"native_functions" ofType:@"js"] encoding:NSUTF8StringEncoding error:nil];
         });
         //添加自定义的脚本
         WKUserScript *js = [[WKUserScript alloc] initWithSource:jsSource injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
         [self.configuration.userContentController addUserScript:js];
         */
//        let s = WKUserScript(source: "alert(document.cookie);", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        let s = WKUserScript(source: "alert(document.cookie);", injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        self.userContentController.addUserScript(s)
    }
    
    lazy var progressView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: progressViewHeight, width: self.webView.frame.size.width, height: progressViewHeight))
        v.backgroundColor = UIColor.blue
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addObserver(webView, forKeyPath: kWebViewTitle, options: .new, context: nil)
    }
    
    convenience init(frame: CGRect, url: String = "", fileName: String = "") {
        self.init(frame: frame)
        if !url.isEmpty {
            self.url = url
            webView.load(self.url.ga_url!.ga_request!)
        }
        if !fileName.isEmpty {
            
            let url = Bundle.main.url(forResource: fileName, withExtension: "html")
            let request = URLRequest(url: url!)
            if #available(iOS 11, *) {
                webView.load(request)
            }else{
                let request = NSMutableURLRequest.init(url: url!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60)
                request.httpMethod = "GET"
//                request.httpBody = ("token=" + tokenValue()).data(using: String.Encoding.utf8)
                webView.load(request as URLRequest)
            }
        }
    }

    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        if (keyPath == kEstimatedProgress) {
            progressView.frame = CGRect(x: 0, y: progressViewHeight, width: self.webView.frame.size.width * CGFloat(webView.estimatedProgress), height: progressViewHeight)
        } else if (keyPath == kWebViewTitle) {
            print(self.webView.title ?? "")
        }
    }
    
    // 执行goBack或reload或goToBackForwardListItem后马上执行loadRequest，即一起执行，在didFailProvisionalNavigation方法中会报错，error.code = -999（ NSURLErrorCancelled）。
    func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
        /// 延迟加载新的url，否则报错-999
        
        self.perform(#selector(performLoadRequest), with: nil, afterDelay: 0.5)
    }
    
    @objc func performLoadRequest() {
        return
//        webView.load(URLRequest())
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
        removeObserver(webView, forKeyPath: kWebViewTitle)
        
        // 对应userContentController.add(self, name: kJS_Name)
        webView.configuration.userContentController.removeScriptMessageHandler(forName: kJS_Name)
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
        if self.webView.frame.height > self.frame.height {
            self.myDelegate?.webViewDidFinish(self.webView.frame.height)
        }
        
        iosCallJS(webView, didFinish: navigation)
    }
    
    private func iosCallJS(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("iOSCallJsAlert('我是ios过来的值')", completionHandler: nil)
    }
    
    // 页面加载失败
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

    }
    
    // <a href="tel:13222223333”>打电话</a>
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        let scheme = url?.scheme
        guard let schemeStr = scheme else { return  }
        if schemeStr == "tel" {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [String : Any](), completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.performDefaultHandling, nil)
    }

    /* JS传值给iOS */
    /*
        js代码：window.webkit.messageHandlers.currentCookies.postMessage(document.cookie);
     */
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if (message.name == kJS_Name) {
            // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull类型
            print(message.body)
        }
    }
    /*
        在JS端调用alert函数时(警告弹窗)，会触发此代理方法。
        通过completionHandler()回调JS
     */
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        self.showView(message)
        completionHandler()
        /*
        let alertController:UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alertController, animated: true) {
            
        }
        */
    }
    /*
        JS端调用confirm函数时(确认、取消式弹窗)，会触发此方法
        completionHandler(true)返回结果
     */
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        self.showView(message)
        completionHandler(true)
        /*
        let alertController:UIAlertController = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "确认", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        self.present(alertController, animated: true) {
            
        }
         */
    }
    /*
        JS调用prompt函数(输入框)时回调，completionHandler回调结果
     */
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        self.showView(prompt)
        completionHandler("^_^")
        /*
        let alertController:UIAlertController = UIAlertController(title: prompt, message: "", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = defaultText
        }
        alertController.addAction(UIAlertAction(title: "完成", style: .default, handler: { (action) in
            completionHandler(alertController.textFields?.first?.text)
        }))
        */
    }
}
