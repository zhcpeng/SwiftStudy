//
//  RootListViewController.swift
//  Swift2.0Study
//
//  Created by zhcpeng on 15/10/21.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class RootListViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    var itemList : NSMutableArray!
    
    var className : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        itemList = [
            "SwiftyJSONViewController",
            "DoubelColumnListViewController",
            "LoadHtml5FileViewController"
        ]
        
        className = [
                    "唯品会专场列表解析(单行)",
                    "惠美丽专场列表解析(双行)",
                    "WebView加载本地html文件"
                    ]
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: - UITablweViewDelegate
extension RootListViewController{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 20
        return itemList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let CellIdentifier : String = "CellIdentifier"
        var cell:UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(CellIdentifier)
        if cell == nil{
            cell = UITableViewCell(style: .Default, reuseIdentifier: CellIdentifier)
        }
        cell.textLabel!.text = className[indexPath.row] as? String
        cell.detailTextLabel?.text = itemList[indexPath.row] as? String
        
        return cell
    }    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SwiftClassFromString(itemList[indexPath.row] as! String)
        self.navigationController?.pushViewController(vc!, animated: true);
    }
}
