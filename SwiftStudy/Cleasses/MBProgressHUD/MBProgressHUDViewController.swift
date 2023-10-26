//
//  MBProgressHUDViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/7/25.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit
//import MBProgressHUD

class MBProgressHUDViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.reactive.controlEvents(.touchUpInside).observeValues({ (_) in
////            let hub = MBProgressHUD.showAdded(to: self.view, animated: true)!
//            let hub = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)!
//            hub.labelText = "测试 \(arc4random()%100)"
//
////            let hub = MBProgressHUD.init(view: HUBView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 50)))!
//
//            hub.removeFromSuperViewOnHide = true
////            hub.show(true)
//            hub.hide(true, afterDelay: 3)
//            hub.isUserInteractionEnabled = false
//            hub.alpha = 0.5
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//                self.navigationController?.pushViewController(UIViewController(), animated: true)
//            })

            XCRToastView.show("XCRToastView \(arc4random()%100) XCRToastViewX CRToastView XCRToastView", type: .success)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.0, execute: {
                self.navigationController?.pushViewController(UIViewController(), animated: true)
            })

            XCRToastView.show("字数超上限了")
        })
        button.backgroundColor = UIColor.red
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        XCRToastView.show("XCRToastView \(arc4random()%100)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        }

//        XCRToastView.show("XCRToastView \(arc4random()%100)")

        test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     测试函数
     - parameters:
        - aa: AA
        - bb: BB
     */
    func test(aa: String = "" , bb: String = "") {

    }
    


}

class HUBView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        let label = UILabel(frame: frame)
        label.text = "测试 \(arc4random()%100)"
        self.addSubview(label)
        label.textAlignment = .center
        label.textColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
