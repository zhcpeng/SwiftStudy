//
//  ViewController.swift
//  Swift3
//
//  Created by zhcpeng on 16/5/27.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

import ReactiveCocoa

class ViewController: UIViewController {
    
    private lazy var privateButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(UIColor.red.withAlphaComponent(0.2), for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var listButton: UIButton = {
        let button = UIButton()
        button.setBackgroundColor(UIColor.green.withAlphaComponent(0.2), for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private var count: Int = 0
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black
//    }

	override func viewDidLoad() {
		super.viewDidLoad()
        
        self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black
        
        self.view.addSubviews([privateButton, listButton])
        privateButton.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(self.view.snp_width).dividedBy(2)
        }
        listButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(self.view.snp_width).dividedBy(2)
        }

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			let vc = RootListController()
			self.navigationController?.pushViewController(vc, animated: true)
		}
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        if sender == privateButton {
            if count >= 2 {
                self.navigationController?.pushViewController(PrivateListViewController(), animated: true)
                count = 0
            } else {
                count += 1
            }
        } else if sender == listButton {
            self.navigationController?.pushViewController(RootListController(), animated: true)
        }
    }

}
