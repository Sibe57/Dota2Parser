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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
