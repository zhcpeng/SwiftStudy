//
//  InsertTableViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/6/5.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// 增量tableView（从底部开始，旋转view(实际没什么作用)）
class InsertTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView: UITableView!
    private var dataSource: [Int] = []
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.frame = CGRect.init(x: 50, y: 100, width: 200, height: 200)
        tableView.backgroundColor = UIColor.red
        tableView.delegate = self
        tableView.dataSource = self
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        view.addSubview(tableView)

        timer = Timer(timeInterval: 2, target: self, selector: #selector(addRow), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)

    }

    @objc func addRow() {
//        dataSource.append(Int(arc4random() % 100))
        dataSource.insert(Int(arc4random() % 100), at: 0)

        if tableView.contentOffset.y > 0 {
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
            tableView.endUpdates()
        } else {
            tableView.beginUpdates()
            tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
            tableView.endUpdates()
        }
//        tableView.beginUpdates()
//        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
//        tableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.transform = CGAffineTransform(scaleX: 1, y: -1)
        cell.textLabel?.text = "\(dataSource[indexPath.row])"
        return cell
    }
    

}
