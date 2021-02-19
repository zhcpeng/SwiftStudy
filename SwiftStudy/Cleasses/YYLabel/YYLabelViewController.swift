//
//  YYLabelViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/8/15.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

//import YYText

class YYLabelViewController: UIViewController {
    
    fileprivate lazy var contentLabel : YYLabel = {
        let label = YYLabel()
        label.numberOfLines = 0
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.addSubview(contentLabel)
        contentLabel.frame = CGRect.init(x: 0, y: 100, width: kScreenWidth, height: 100)
        
        let text = NSMutableAttributedString.init(string: "测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试...全文", attributes: nil)
        text.yy_setTextHighlight(NSRange.init(location: text.length - 2, length: 2), color: UIColor.blue, backgroundColor: UIColor.clear) { (_, _, _, _) in
            print("点击 全文")
        }
        contentLabel.attributedText = text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
