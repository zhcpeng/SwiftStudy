//
//  CellDidEndDispalyViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2020/9/3.
//  Copyright © 2020 zhcpeng. All rights reserved.
//

import UIKit
//import ReactiveCocoa

class CellDidEndDispalyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    private let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.frame = CGRect(x: 0, y: 150, width: self.view.bounds.size.height, height: 300)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let button = UIButton(type: .custom)
        button.setTitle("relolad", for: .normal)
        button.reactive.controlEvents(.touchUpInside).observeValues { [weak self](_) in
            self?.tableView.reloadData()
        }
        button.backgroundColor = UIColor.red
        button.frame = CGRect(x: 0, y: 100, width: 200, height: 50);
        self.view.addSubview(button)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("%@", cell.textLabel?.text ?? "\(indexPath.row)")
    }
    

}
