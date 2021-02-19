//
//  XButtonViewController.swift
//  Swift3
//
//  Created by ZhangChunPeng on 2017/11/22.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class XButtonViewController: UIViewController {

    private let iPhoneX = (CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        let button = UIButton(type: .custom)
        button.setTitle("按钮", for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(UIColor.red), for: .normal)
        button.setBackgroundImage(UIImage.imageWithColor(UIColor.green), for: .highlighted)

        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(48 + (iPhoneX ? 34 : 0))
        }
        if iPhoneX {
            button.titleEdgeInsets = UIEdgeInsets.init(top: -17, left: 0, bottom: 17, right: 0)
        }



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
