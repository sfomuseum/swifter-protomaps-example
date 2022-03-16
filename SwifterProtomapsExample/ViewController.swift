//
//  ViewController.swift
//  SwiferProtomapsExample
//
//  Created by asc on 3/15/22.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // swifter server and swifter-protomaps handler are configured in AppDelegate.swift
        
        guard let www_url = URL(string: Bundle.main.resourcePath! + "/www.bundle/") else {
            return
        }
        
        let wk_conf = WKWebViewConfiguration()
        
        let index_url = www_url.appendingPathComponent("index.html")
        let str_url = "file://" + index_url.absoluteString
        
        guard let file_url = URL(string:str_url) else {
            return
        }
        
        let request = URLRequest(url: file_url)

        webView = WKWebView(frame: .zero, configuration: wk_conf)
        webView.navigationDelegate = self
        view = webView
        
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 
    }
}

