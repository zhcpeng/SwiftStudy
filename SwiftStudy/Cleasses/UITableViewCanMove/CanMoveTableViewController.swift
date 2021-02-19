//
//  CanMoveTableViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/7/1.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

class CanMoveTableViewController: UITableViewController {

	var itemList = Array<String>()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
		self.tableView.isEditing = true

		for i in 0..<20 {
			itemList.append(String(i))
		}

	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - Table view data source

	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
		cell.textLabel?.text = itemList[indexPath.row]

		// Configure the cell...

		return cell
	}


	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
		let string = itemList[fromIndexPath.row]
		itemList[fromIndexPath.row] = itemList[toIndexPath.row]
		itemList[toIndexPath.row] = string
	}

	override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .none
	}

}
