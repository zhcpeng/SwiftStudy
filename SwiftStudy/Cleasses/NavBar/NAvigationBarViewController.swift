//
//  NAvigationBarViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2019/11/6.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import UIKit

class NAvigationBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let button = UIButton()
        button.setTitle("右按钮", for: .normal)
        button.sizeToFit()
        let item = UIBarButtonItem.init(customView: button)
//        self.navigationItem.rightBarButtonItem = item
        
        let search = UIButton()
        search.setImage(UIImage(named: "search"), for: .normal)
        search.sizeToFit()
        let itemSearch = UIBarButtonItem(customView: search)
        
        let itemSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.fixedSpace, target: nil, action: nil)
        itemSearch.width = -20
        self.navigationItem.rightBarButtonItems = [itemSpace, itemSearch, item]
    }
    

}
