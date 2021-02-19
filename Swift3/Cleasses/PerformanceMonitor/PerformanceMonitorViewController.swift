//
//  PerformanceMonitorViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/7/25.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// 卡顿监测
class PerformanceMonitorViewController: UIViewController {

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        PerformanceMonitorSwift.share.start()
//        PerformanceMonitor.sharedInstance().start()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            PerformanceMonitorSwift.share.stop()
//        }

    }

    deinit {
        print("\(#function)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension PerformanceMonitorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        var string = "\(indexPath.row)"
        if indexPath.row % 5 == 0 {
            usleep(300*1000)
            string = "测试卡顿"
        }
        cell.textLabel?.text = string
        return cell
    }
}
