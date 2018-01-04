//
//  Webpage.swift
//  Lab4
//
//  Created by Camilla Moraes on 10/22/17.
//  Copyright © 2017 Camilla Moraes. All rights reserved.
//

import UIKit
import WebKit

class Webpage: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect(x:0, y:110, width: self.view.frame.width, height: self.view.frame.height - 20), configuration: WKWebViewConfiguration())
        self.view.addSubview(webView)

        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://themoviedb.org/")!
        let myURLRequest = URLRequest(url: url)
        webView.load(myURLRequest)
        
        self.navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
