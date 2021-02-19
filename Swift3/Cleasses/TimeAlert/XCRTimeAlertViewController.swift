//
//  XCRTimeAlertViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/6/1.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

class XCRTimeAlertViewController: UIAlertController {

    private var time: Int = 0
    private var timer: Timer?
    private var cancelAction: UIAlertAction!
    private var cancelString: String = ""

    init(_ title: String, message: String? = nil, time: Int, okAction: UIAlertAction, cancelString: String = "取消") {
        super.init(nibName: nil, bundle: nil)
        self.setValue(UIAlertController.Style.alert.rawValue, forKey: "preferredStyle")
        self.title = title
        self.message = message
        self.time = time
        self.cancelString = cancelString
        cancelAction = UIAlertAction(title: cancelString + (time > 0 ? "(\(time))" : ""), style: .destructive, handler: nil)
        self.addAction(okAction)
        self.addAction(cancelAction)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        timer?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if time > 0 {
            timer = Timer(timeInterval: 1, target: self, selector: #selector(setCancelTitle), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        }
    }

    deinit {
        print("定时器alert 释放")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func setCancelTitle() {
        time -= 1
        if time > 0 {
            cancelAction.setValue(cancelString + "(\(time))", forKey: "title")
        } else {
            timer?.invalidate()
            self.dismiss(animated: true, completion: nil)
        }
    }

}
