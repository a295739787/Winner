//
//  PrivacyWebViewController.swift
//  Winner
//
//  Created by 一只莫得感情的寒鱼 on 2022/10/24.
//

import UIKit
import WebKit

class PrivacyWebViewController: LMHBaseViewController,WKNavigationDelegate,WKUIDelegate{

    var url : String = ""
    var urlName : String = ""
    var isHiddenNavgationBar :Bool = false
    var webView = WKWebView()
   
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        if !isHiddenNavgationBar {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isHiddenNavgationBar {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (urlName.isEmpty){
          urlName = "服务协议"
        }
        self.customNavBar.title = urlName
        
        loadSubView()
        
    }
    
    private func loadSubView(){
        let config = WKWebViewConfiguration.init()
        let preference = WKPreferences.init()
        preference.minimumFontSize = 0
        preference.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preference

        let y = (44 + UIApplication.shared.statusBarFrame.height)
        webView = WKWebView.init(frame: CGRect(x: 0, y: y, width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-y), configuration: config)
        // 是否允许手势左滑返回上一级, 类似导航控制的左滑返回
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        
        if url != "" {
            let webUrl = URL(string: url)
            let request = URLRequest(url: webUrl!)
            webView.load(request)
        }
        
    }


}
