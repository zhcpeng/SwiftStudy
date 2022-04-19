//
//  UISecondViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/3/7.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class UISecondViewController: UIViewController {
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
            let vc = UIThirdViewController();
            vc.modalPresentationStyle = .fullScreen;
            self?.present(vc, animated: true, completion: nil)
        })
        return button
    }()
    
    private lazy var disassButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.darkGray
        button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
            self?.navigationController?.dismiss(animated: true, completion: nil)
        })
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.green
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        view.addSubview(disassButton)
        disassButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(200)
            make.width.height.equalTo(100)
        }
        
    }

    deinit {
        print("\(#file):\(#function)")
    }

}


