//
//  AddSubviewViewController.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/3/29.
//

import UIKit

class AddSubviewViewController: UIViewController {
    
    private let singleView = UIView();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let btn1 = UIButton()
        btn1.setBackgroundColor(UIColor.red, for: .normal);
        btn1.reactive.controlEvents(.touchUpInside).observeValues { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.view.addSubview(weakSelf.singleView)
            weakSelf.singleView.backgroundColor = UIColor.orange
            weakSelf.singleView.frame = CGRect(x: 0, y: 300, width: 200, height: 100)
        };
        btn1.frame = CGRect(x: 0, y: 100, width: 100, height: 50);
        self.view .addSubview(btn1);
        
        let btn2 = UIButton()
        btn2.setBackgroundColor(UIColor.red, for: .normal);
        btn2.reactive.controlEvents(.touchUpInside).observeValues { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.view.addSubview(weakSelf.singleView)
            weakSelf.singleView.backgroundColor = UIColor.brown
            weakSelf.singleView.frame = CGRect(x: 0, y: 400, width: 200, height: 100)
        };
        btn2.frame = CGRect(x: 200, y: 100, width: 100, height: 50);
        self.view.addSubview(btn2);
        
    }
    

}
