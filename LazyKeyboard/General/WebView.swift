//
//  WebView.swift
//  LazyKeyboard
//
//  Created by sunny on 2018/3/3.
//  Copyright © 2018年 CepheusSun. All rights reserved.
//


import UIKit
import WebKit
import RxCocoa
import RxSwift

final class WebController: UIViewController, WKNavigationDelegate {
    
    /// url 链接
    var webURL: URL?
    
    /// HTML 文本
    var webContent: String?
    
    var isShareAllowed: Bool = false
    
    
    fileprivate lazy var wkWebView: WKWebView = {
        
        let infoDictionary = Bundle.main.infoDictionary!
        let version = infoDictionary["CFBundleShortVersionString"]!
        
        let jsStr = "localStorage.setItem('appVersion', '\(version)')"
        let script = WKUserScript(source: jsStr,
                                  injectionTime: .atDocumentStart,
                                  forMainFrameOnly: false)
        let config = WKWebViewConfiguration()
        config.userContentController.addUserScript(script)
        
        let web = WKWebView(frame: CGRect.zero, configuration: config)
        web.navigationDelegate = self
        self.view.addSubview(web)
        return web
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(frame: .zero)
        progress.tintColor = .orange
        progress.trackTintColor = .white
        view.addSubview(progress)
        return progress
    }()
    
    var kvo: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        wkWebView.frame = view.bounds
        progressView.x = 0
        progressView.y = 0
        progressView.height = 2
        progressView.right = view.right
        
        webURL.ifSome {[unowned self] (url) in
            let urlRequest = URLRequest(url: url)
            self.wkWebView.load(urlRequest)
        }
        webContent.ifSome {[unowned self] (html) in
            self.wkWebView.loadHTMLString(html, baseURL: nil)
        }
        
        kvo = wkWebView.observe(\.estimatedProgress) {[weak self] (obj, changed) in
            let new = obj.estimatedProgress
            if new == 1 {
                self?.progressView.isHidden = true
            } else {
                self?.progressView.isHidden = false
                self?.progressView.setProgress(Float(new), animated: true)
            }
        }
    }
}

// MARK: - WKNavigationDelegate
extension WebController {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        webView.url.ifSome {
            if $0.absoluteString.hasPrefix("https://itunes.apple.com") {
                UIApplication.shared.open(navigationAction.request.url!, options: [:]
                    , completionHandler: nil)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }

    }
    
}
