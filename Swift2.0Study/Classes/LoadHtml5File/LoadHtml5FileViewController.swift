//
//  LoadHtml5FileViewController.swift
//  Swift2Study
//
//  Created by zhcpeng on 15/11/19.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class LoadHtml5FileViewController: UIViewController ,UIWebViewDelegate {

    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let path = NSBundle.mainBundle().pathForResource("list", ofType: "html")
        let localeUrl = NSURL(fileURLWithPath: path!)
        let request = NSURLRequest(URL: localeUrl)
        self.myWebView.loadRequest(request)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoadHtml5FileViewController{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        NSLog("%@", (request.URL)!)
        
        return true
    }
}
