//
//  StretchViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/12/28.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

class StretchViewController: UIViewController {
    
    private lazy var scrollView :UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private lazy var stretchView : StretchView = {
        let view = StretchView()
        view.scrollView = self.scrollView
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        scrollView.addSubview(stretchView)
        stretchView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 200)
        scrollView.contentSize = CGSize.init(width: kScreenWidth, height: 1000)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
