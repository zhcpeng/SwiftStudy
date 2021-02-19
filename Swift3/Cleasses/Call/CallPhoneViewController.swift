//
//  CallPhoneViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/10/12.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit
import WebKit

class CallPhoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func callPhone(_ sender: UIButton) {
        let phone = "telprompt://10010"
        UIApplication.shared.openURL(URL.init(string: phone)!)
    }

}
