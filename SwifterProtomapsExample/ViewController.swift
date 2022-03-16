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
        
        // Ensure that the local HTTP server is running
        // To do: If not running signal the web application via the JavaScript
        // bridge and report an error / provide feedback.
        
        guard let url = URL(string: "http://localhost:9001") else {
            print("Failed to create URL")
            return
        }
        
        var req = URLRequest(url: url)
        req.httpMethod = "GET"
                
        let task = URLSession.shared.dataTask(with: req) { [self] data, response, error in
                        
            guard let rsp = response as? HTTPURLResponse else {
                print("Bunk response")
                return
            }
            
            if error != nil {
                print("Server returned an error, \(String(describing: error))")
                return
            }
            
            if rsp.statusCode != 200 {
                print("Server returned unexpected status code \(rsp.statusCode)")
                return
            }
        }
        
        // print("Fetch \(url)")
        task.resume()
    }
}

