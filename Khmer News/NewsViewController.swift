//
//  NewsViewController.swift
//  Khmer News
//
//  Created by ភី ម៉ារ៉ាសុី on 10/24/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    var newsTitle = String()
    var newsArticle = String()
    var newsImage1 = String()
    let newsImage2 = ""
    let newsImage3 = ""
    let newsImage4 = ""
    let newsImage5 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        view.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        self.webView.loadHTMLString("<html><body><div><h3 style='font-family: hanuman; color: #11558F;'>\(self.newsTitle)</h3><br><center><img width='100%' src=\"\(self.newsImage1)\"/></center><br><br><center><div style='font-family: hanuman; color: #626262; text-align: justify;'>\(self.newsArticle)</div></div><img width='100%' src=\"\(self.newsImage2)\"/></center><br><br><center><img width='100%' src=\"\(self.newsImage3)\"/></center><br><br><center><img width='100%' src=\"\(self.newsImage4)\"/></center><br><br><center><img width='100%' src=\"\(self.newsImage5)\"/></center></body></html>", baseURL: Bundle.main.bundleURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
