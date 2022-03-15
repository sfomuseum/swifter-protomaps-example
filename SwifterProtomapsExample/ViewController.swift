//
//  ViewController.swift
//  SwiferProtomapsExample
//
//  Created by asc on 3/15/22.
//

import UIKit
import WebKit
import Swifter
import SwifterProtomaps

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        guard let www_url = URL(string: Bundle.main.resourcePath! + "/www.bundle/") else {
            return
        }
        
        do {
            
            let root_url = www_url.appendingPathComponent("pmtiles")
                        
            let port: in_port_t  = 9000
            let server = HttpServer()
                            
                var opts = ServeProtomapsOptions(root: root_url)
                opts.AllowOrigins = "*"
                opts.AllowHeaders = "*"
                
                server["/pmtiles/:path"] = ServeProtomapsTiles(opts)
                
                try server.start(port)
                print("OKAY")
                
        } catch {
            print("Failed to start PM tiles server \(error)")
            return
        }
        
        let wk_conf = WKWebViewConfiguration()
        
        let index_url = www_url.appendingPathComponent("index.html")
        let str_url = "file://" + index_url.absoluteString
        
        guard let file_url = URL(string:str_url) else {
            return
        }
        
        let request = URLRequest(url: file_url)

        // https://stackoverflow.com/questions/25553711/disable-magnification-gesture-in-wkwebview
        
        webView = WKWebView(frame: .zero, configuration: wk_conf)
        webView.navigationDelegate = self
        view = webView
        
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 
    }
}

