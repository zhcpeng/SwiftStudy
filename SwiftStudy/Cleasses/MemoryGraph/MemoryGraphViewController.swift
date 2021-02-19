//
//  MemoryGraphViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/5/25.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// 测试 MemoryGraph !!!此页面有内存泄露
class MemoryGraphViewController: UIViewController {

    var mView: MemoryGraphView?
    var label: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        mView = MemoryGraphView.init(test)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func test() {
        print("111111")
        label.text = "11111"
    }

}


class MemoryGraphView: UIView {
    var action: (() -> Void)?

    init(_ action: @escaping (() -> Void)) {
        self.action = action
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
