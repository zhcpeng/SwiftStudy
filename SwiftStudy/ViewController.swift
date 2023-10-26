//
//  ViewController.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/2/19.
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
        
        self.view.window?.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black
        
        self.view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.white : UIColor.black
        
        self.view.addSubviews([privateButton, listButton])
        privateButton.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(self.view.snp.width).dividedBy(2)
        }
        listButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.width.equalTo(self.view.snp.width).dividedBy(2)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let vc = RootListController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
//        var
        let label = UILabel()
        label.frame = CGRect(x: 10, y: 100, width: 200, height: 30)
        label.textColor = UIColor.red
        self.view.addSubview(label)
        
        var date: Date? = nil
        if (TaskInfoTool.runORDebug()) {
            date = Date();
            UserDefaults.standard.set(Date(), forKey: "kLastInit")
        } else {
            date = UserDefaults.standard.object(forKey: "kLastInit") as? Date
        }
        if var d = date {
            d = d.addingTimeInterval(60 * 60 * 24 * 7)
            
            let formater = DateFormatter()
            formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
            formater.locale = NSLocale.system
            let s = formater.string(from: d)
            label.text = s;
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

