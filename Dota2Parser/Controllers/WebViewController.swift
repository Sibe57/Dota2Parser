//
//  WebViewController.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 29.06.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url: String!
    var contentName: String!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = contentName
        
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
    }
}
