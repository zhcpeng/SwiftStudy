//
//  PrivateListViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2020/12/24.
//  Copyright © 2020 zhcpeng. All rights reserved.
//

import UIKit

class PrivateListViewController: UITableViewController {

    private var itemList: [AnyClass] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemList.append(DownloadListViewController.self)
        itemList.append(LocalImageBrowerViewController.self)
        itemList.append(CopyImageViewController.self)
        itemList.append(ImageLibraryViewController.self)

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = NSStringFromClass(itemList[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let c = itemList[indexPath.row] as? UIViewController.Type {
            navigationController?.pushViewController(c.init(), animated: true);
        }
    }

}
