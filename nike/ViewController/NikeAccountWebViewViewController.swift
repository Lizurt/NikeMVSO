//
//  WebViewController.swift
//  nike
//
//  Created by Pasha on 20.01.2025.
//

import UIKit
import WebKit

//                  ViewView ¯\_(ツ)_/¯
class NikeAccountWebViewViewController: UIViewController {
    
    private final var urlString: String = "https://accounts.nike.com"
    private final var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: self.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
