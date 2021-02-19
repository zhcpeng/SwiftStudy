//
//  SecurityViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2020/9/4.
//  Copyright © 2020 zhcpeng. All rights reserved.
//

import UIKit
import Security
import LocalAuthentication

class SecurityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .custom);
        button.setTitle("开启验证", for: .normal);
        button.frame = CGRect(x: 5, y: 100, width: 100, height: 50);
        button.backgroundColor = UIColor.red
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside);
        self.view.addSubview(button)
        
        let button2 = UIButton(type: .custom);
        button2.setTitle("登录验证", for: .normal);
        button2.frame = CGRect(x: 5, y: 200, width: 100, height: 50);
        button2.backgroundColor = UIColor.red
        button2.addTarget(self, action: #selector(buttonAction2), for: .touchUpInside);
        self.view.addSubview(button2)
        
        
        enum xc {
            case a
            case b
            case c
        }
        
//        var x : xc
//
//        switch x {
//        case .a:
//            <#code#>
//        default:
//            <#code#>
//        }
        
    }
    
    @objc func buttonAction() {
        let context = LAContext()
        
//        if context.biometryType == .faceID {
//            // 面容
//
//        } else if context.biometryType == .touchID {
//            // 指纹
//
//        } else {
//
//        }
        
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
        } else {
            print("不支持指纹面容")
        }
    }
    
    @objc func buttonAction2() {
        
    }


}
