//
//  DoubelColumnListViewController.swift
//  Swift2Study
//
//  Created by zhcpeng on 15/11/13.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class DoubelColumnListViewController: UITableViewController {
    
//    var myTableView : UITableView!
//    var itemJSON : JSON = JSON.null
    var itemJSON : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemJSON = NSMutableArray()
        self.tableView.separatorStyle = .None
        
        let url : String = "http://mobile.hml365.com//services/Main/getmpList"
        let parameters : Dictionary = ["MainType":"2","PageNum":"1"]
        Alamofire.request(.POST, url, parameters: parameters)
            .responseJSON { response in
                do{
                    let dictionary: AnyObject? = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
                    if let dictionary = dictionary as? Dictionary<String, AnyObject> {
                        let msg = dictionary["msg"]
                        if let msg = msg as? NSArray {
                            for json in msg{
                                if let dict = json as? Dictionary<String, AnyObject>{
                                    let model : ProductModel = ProductModel.objectWithKeyValues(dict)
                                    self.itemJSON.addObject(model)
                                }
                            }
                            let temp : NSMutableArray = NSMutableArray()
                            temp.addObjectsFromArray(self.itemJSON as [AnyObject])
                            temp.addObjectsFromArray(self.itemJSON as [AnyObject])
                            temp.addObjectsFromArray(self.itemJSON as [AnyObject])
                            temp.addObjectsFromArray(self.itemJSON as [AnyObject])
                            self.itemJSON = temp
                            
                            self.tableView.reloadData()
                        }
                        
                    } else {

                    }
                }catch{
                    
                }

        }
        
    }

    
    //MARK: - UITablweViewDelegate
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemJSON.count / 2 + (self.itemJSON.count % 2 == 1 ? 1:0)
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let height = kGetCurrentHeight(145, H: 145) + 80
        return height
//        return kGetCurrentHeight(145, H: 145) + 80
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let CellIdentifier :String = "DoubelColumnCell"
        var cell : DoubelColumnCell!  = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? DoubelColumnCell
        if cell == nil{
            tableView.registerNib(UINib(nibName: CellIdentifier, bundle: nil), forCellReuseIdentifier: CellIdentifier)
            cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? DoubelColumnCell
            cell.selectionStyle = .None
        }
        
        cell.model1 = self.itemJSON[indexPath.row * 2] as! ProductModel
        if indexPath.row * 2 + 1 < self.itemJSON.count{
            cell.model2 = self.itemJSON[indexPath.row * 2 + 1] as! ProductModel
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("%d", indexPath.row + 1)
        
        //        let cell :SwiftyJSONViewCell! = tableView.cellForRowAtIndexPath(indexPath) as? SwiftyJSONViewCell
        //        NSLog("%@", String(cell.cellImage.frame))
        //        NSLog("%@", String(cell.cellLabel.frame))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
