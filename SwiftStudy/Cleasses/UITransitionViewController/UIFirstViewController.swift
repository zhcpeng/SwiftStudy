//
//  UIFirstViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/3/7.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class UIFirstViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
            let nav = UINavigationController(rootViewController: UISecondViewController())
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true, completion: nil)
        })
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(50)
        }
    }
    
    deinit {
        print("\(#file):\(#function)")
    }

}
