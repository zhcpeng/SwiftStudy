//
//  TempViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2020/8/27.
//  Copyright © 2020 zhcpeng. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let bt1 = XCRMoreButton.init(type: .custom)
        bt1.setTitle("bt1111", for: .normal)
        bt1.setImage(UIImage(named: "search"), for: .normal)
        bt1.backgroundColor = UIColor.green
        
        let bt2 = XCRMoreButton.init(type: .custom)
        bt2.setTitle("bt2222", for: .normal)
        bt2.setImage(UIImage(named: "search"), for: .normal)
        bt2.backgroundColor = UIColor.red
        
        let bt3 = XCRMoreButton.init(type: .custom)
        bt3.setTitle("bt333", for: .normal)
        bt3.setImage(UIImage(named: "search"), for: .normal)
        bt3.backgroundColor = UIColor.orange
        bt3.frame = CGRect(x: 50, y: 250, width: 200, height: 50);
        self.view.addSubview(bt3)
        
        bt3.touchExtendInset = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        
        self.view.addSubview(bt1)
        bt1.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.view.addSubview(bt2)
        bt2.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(100)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
