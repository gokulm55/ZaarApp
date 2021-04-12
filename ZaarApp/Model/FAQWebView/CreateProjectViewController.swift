//
//  WebViewController.swift
//  ZaarApp
//
//  Created by apple on 02/04/21.
//

import UIKit
import WebKit
import SafariServices
class CreateProjectViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    var activityIndicator: UIActivityIndicatorView!
    var webView: WKWebView!
       override func viewDidLoad() {
          super.viewDidLoad()
        view.backgroundColor = .white
        webView = WKWebView(frame: CGRect.zero)
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        view.addSubview(webView)
        
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityIndicator)
        
//        let uType = UserDefaults.standard.integer(forKey: "uType")
        var urlLink: URL?
       // http error on live upload app store to check
        /*<key>NSAppTransportSecurity</key>
         <dict>
             <key>NSAllowsArbitraryLoads</key>
             <true/>
         </dict>
         
         using below link
         */
            guard let link = URL(string: "https://console.zaarapp.com/login") else { return  }
            urlLink = link
//            print("usertype",uType)
        let request = URLRequest(url: urlLink!)
        webView.load(request)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let rightShareBtn = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain
                                       , target: self, action: #selector(shareBarButton))
        navigationItem.rightBarButtonItem = rightShareBtn
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        webView.frame = view.bounds
    }
    
    
    
    func showActivityIndicator(show: Bool) {
           if show {
               activityIndicator.startAnimating()
           } else {
               activityIndicator.stopAnimating()
           }
       }

       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           showActivityIndicator(show: false)
       }

       func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
           showActivityIndicator(show: true)
       }

       func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
           showActivityIndicator(show: false)
       }
    
    @objc func shareBarButton(){
        let url = "https://console.zaarapp.com/login"
        
        let shareItems:Array = [url]
           let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
           self.present(activityViewController, animated: true, completion: nil)
          
        
        
    }
    
    
}
