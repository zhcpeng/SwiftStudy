//
//  NameSpaceViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/7/26.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

class NameSpaceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView()
        view.backgroundColor = UIColor.blue
        view.xcar.add(self.view).snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        let string = "(1,2,((3,4),(5,6))"
        if let text = test(string) {
            print(text)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test(_ text: String) -> String? {
        var temp: [Character] = []
        var result: String = ""
        for i in text {
            if i == "(" {
                temp.append(i)
            } else if i == ")" {
                if temp.isEmpty {
                    return nil
                }
                temp.removeLast()
            } else {
                result += String(i)
            }
        }
        return temp.isEmpty ? ("(" + result + ")") : nil
    }


}
