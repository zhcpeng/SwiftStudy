//
//  RTLabelViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 17/1/6.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit
//import RTLabel
//import YYText

class RTLabelViewController: UIViewController {
    
//    private lazy var label : RTLabel = {
//        let view = RTLabel(frame: CGRect.zero)
//        view.backgroundColor = UIColor.green
//        return view
//    }()
    
    private lazy var label1 : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.backgroundColor = UIColor.green
        view.numberOfLines = 2
        view.text = "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
        return view
    }()
    
    private lazy var label2 : UILabel = {
        let view = UILabel(frame: CGRect.zero)
        view.backgroundColor = UIColor.red
        view.text = "AAAAAAA"
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        view.addSubview(label)
//        label.frame = CGRect.init(x: 0, y: 100, width: 300, height: 100)
//        label.snp.makeConstraints { (make) in
//            make.edges.equalTo(view)
//        }
        
//        label.textAlignment = RTTextAlignmentJustify
//        label.lineBreakMode = RTTextLineBreakModeClip
//        label.text = "<font color=\"#8E919C\">华晨华晨华晨</font><font color=\"red\">宝马</font>-之诺"
//        label.text = "<font face='HelveticaNeue-CondensedBold' size=20><u color=blue>underlined</u> <uu color=red>text</uu></font>"
//        print(label)


//        label.text = "您发表的帖子 《系统消息，哈哈哈》 被 无线测试 限时高亮 。 操作理由：限时高亮，如有异议，联系 <a href=\"appxcar://m.xcar.com.cn.sendmessage?params=%7B%22uid%22%3A100066%2C%22username%22%3A%22%5Cu7231%5Cu5361%5Cu5ba2%5Cu670d%22%7D\">爱卡客服</a>"
        
        
        view.addSubview(label1)
        view.addSubview(label2)
        label1.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(200)
            make.left.equalToSuperview().offset(20)
            make.right.lessThanOrEqualTo(label2.snp.left).offset(-20)
        }
        label2.snp.makeConstraints { (make) in
            make.top.equalTo(label1)
            make.right.equalToSuperview().offset(-20)
        }
        
//        label2.setContentHuggingPriority(UILayoutPriorityRequired, for: .horizontal)
        label2.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
        
        
        
        let yyLabel = YYLabel()
        yyLabel.text = "<font color=\"#8E919C\">华晨华晨华晨</font><font color=\"red\">宝马</font>-之诺"
        
        
        view.addSubview(yyLabel)
        yyLabel.frame = CGRect.init(x: 0, y: 300, width: 50, height: 100)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
