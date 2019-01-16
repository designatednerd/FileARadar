//
//  DetailViewController.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet private var webView: WKWebView!
    @IBOutlet private(set) var expectedBehaviorLabel: UILabel!
    
    var afterViewLoadedAction: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.navigationDelegate = self
        self.afterViewLoadedAction?()
        self.afterViewLoadedAction = nil
    }
    
    func loadURLRequest(_ urlRequest: URLRequest) {
        self.webView.load(urlRequest)
    }
    
    func loadDocument(fileURL: URL, folderURL: URL? = nil) {
        self.webView.loadFileURL(fileURL, allowingReadAccessTo: folderURL ?? fileURL)
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Did start provisional navigation")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Did fail navigation: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Did fail provisional navigation: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Did finish navigation")
    }
}

