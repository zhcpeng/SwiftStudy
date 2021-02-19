//
//  SectionTableViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/11/23.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

class SectionTableViewController: UITableViewController {
    
    fileprivate var timer : DispatchSource!
    
    fileprivate var count : Int = 5
    fileprivate var all : Bool = false
    
    fileprivate var itemList : [Int] = [1,2,3,4,5,6,7,8,9]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 40
        tableView.sectionFooterHeight = 30
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "Section")
        tableView.isEditing = true
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenWidth, height: 100))
        view.backgroundColor = UIColor.green
        tableView.tableFooterView = view
//        tableView.tableHeaderView = view
        
//         timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
//        dispatch_source_set_timer(timer, dispatch_walltime(nil, 0), 2 * NSEC_PER_SEC, 0)
//        dispatch_source_set_event_handler(timer) { 
//            print("111")
//            self.all = !(self.all)
//            self.tableView.reloadData()
////            self.count++
//        }
//        dispatch_resume(timer)
        
        
//        let memoryManagedResult:String = StringByAddingTwoStrings(str1, str2).takeUnretainedValue()
        
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
        return itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "\(itemList[indexPath.row])"

        return cell
    }
    
//    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = tableView.dequeueReusableHeaderFooterViewWithIdentifier("Section")
//        view?.contentView.backgroundColor = UIColor.redColor()
//        return view
//    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle  == .delete {
            itemList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
