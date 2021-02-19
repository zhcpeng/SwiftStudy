//
//  TimeAlertViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/6/1.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// 自动消失 alertView
class TimeAlertViewController: UIViewController {

    private var alert: UIAlertController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.reactive.controlEvents(.touchUpInside).observeValues { [weak self](_) in
            self?.showAlert()
        }
        self.view.addSubview(button)
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 100)

    }

    func showAlert() {
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            print("确定")
        }
        let xcrAlert = XCRTimeAlertViewController.init("确定停止吗", message: nil, time: 5, okAction: okAction, cancelString: "取消")
        self.present(xcrAlert, animated: true, completion: nil)

//        return
//
//        let alert = UIAlertController(title: "确定停止吗", message: nil, preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "取消(5)", style: .destructive, handler: nil)
//        let ok = UIAlertAction(title: "确定", style: .default) { (_) in
//            print("确定")
//        }
//        alert.addAction(ok)
//        alert.addAction(cancel)
//        self.present(alert, animated: true, completion: nil)
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            cancel.setValue("取消(4)", forKey: "title")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
