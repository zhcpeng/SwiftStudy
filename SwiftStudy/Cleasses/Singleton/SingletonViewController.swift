//
//  SingletonViewController.swift
//  Swift4
//
//  Created by 张春鹏 on 2018/8/22.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

class SingletonViewController: UIViewController {

    private let singleton = SwiftSingleton.default

    private var timer: Timer!

    private var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print(singleton)

        weak var weakSelf = self
        timer = Timer.init(timeInterval: 1, target: weakSelf!, selector: #selector(test), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)

//        if #available(iOS 10.0, *) {
////            var count: Int = 0
//            timer = Timer.init(timeInterval: 1, repeats: true, block: { [weak self](_) in
//                guard let weakSelf = self else {
//                    print("!!!!!!")
//                    return
//                }
//                weakSelf.count += 1
//                print(weakSelf.count)
//            })
//            RunLoop.main.add(timer, forMode: .commonModes)
//        } else {
//            // Fallback on earlier versions
//        }
    }

    @objc func test() {
//        print(count)
        print("1111")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("\(#function)")
    }

}

fileprivate class SwiftSingleton: NSObject {
    static let `default` = SwiftSingleton()
}
