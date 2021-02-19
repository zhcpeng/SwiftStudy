//
//  TaxViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2019/1/7.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import UIKit

class TaxViewController: UIViewController {
    
    private let label = UILabel()
    private var text = "文本"

    override func viewDidLoad() {
        super.viewDidLoad()

        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.backgroundColor = UIColor.red
        label.frame = CGRect(x: 20, y: 100, width: 100, height: 60)
        label.preferredMaxLayoutWidth = 100
        
        self.view.addSubview(label)
        
        let button = UIButton()
        button.setTitle("Change", for: .normal)
        button.addTarget(self, action: #selector(addText)
            , for: .touchUpInside)
        button.backgroundColor = UIColor.green
        self.view.addSubview(button)
        button.frame = CGRect(x: 20, y: 200, width: 100, height: 40)
    }
    
    @objc private func addText() {
        text += "文本"
        label.text = text
    }

}
