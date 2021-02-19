//
//  UISecondViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/3/7.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class UISecondViewController: UIViewController {
//    var vc = UIThirdViewController()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
//            self?.present(self!.vc, animated: true, completion: nil)
            self?.present(UIThirdViewController(), animated: true, completion: nil)
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
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        XCRPhotoDismissManager.share.initInter()
//        XCRPhotoDismissManager.share.interactiveTransition?.viewController = self.navigationController
//    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        XCRPhotoDismissManager.share.interactiveTransition?.viewController = nil
//        XCRPhotoDismissManager.share.releaseInter()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("\(#file):\(#function)")
    }

}


