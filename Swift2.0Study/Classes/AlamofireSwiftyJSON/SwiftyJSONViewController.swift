//
//  SwiftyJSONViewController.swift
//  Swift2.0Study
//
//  Created by zhcpeng on 15/10/21.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class SwiftyJSONViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
//    var itemList :NSMutableArray!
    var itemJSON : JSON = JSON.null
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        itemList = NSMutableArray()
        
        let urlString : String! = "http://mapi-shop.appvipshop.com/vips-mobile/router.do?api_key=04e0dd9c76902b1bfc5c7b3bb4b1db92&api_sign=ae1bbba9a1efb1d0b4fea6b7eaeb87b0&app_name=shop_ipad&app_version=2.9&child_menu_id=592&client_type=ipad&format=json&mars_cid=915eb66871a0efddde8fb8a325957c75d6cd78b8&menu_id=1&service=mobile.brand.sellingsoon.get&timestamp=1436926538&user_id=3333955&ver=2.0&warehouse=VIP_BJ"
        
        Alamofire.request(.GET, urlString)
            .responseJSON { response in
                let json = JSON.init(data: response.data!)
                let data = json["data"]
                self.itemJSON = data[0]["brands"]
                self.myTableView.reloadData()
        }
    }
    
    //MARK: - UITablweViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemJSON.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 180
        return kGetCurrentHeight(308, H: 145) + 35
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let CellIdentifier :String = "CellIdentifier"
        var cell : SwiftyJSONViewCell!  = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? SwiftyJSONViewCell
        if cell == nil{
            tableView.registerNib(UINib(nibName: "SwiftyJSONViewCell", bundle: nil), forCellReuseIdentifier: CellIdentifier)
            cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as? SwiftyJSONViewCell
        }
        var dict = itemJSON[indexPath.row]
        cell.cellLabel.text = dict["brand_name"].string!
//        cell.cellLabel.alignTop()
        var imgURL : String? = dict["mobile_image_one"].description
        if imgURL != nil {
            if imgURL!.componentsSeparatedByString("upcb").count > 1{
                imgURL = "http://pic1.vip.com/upload/brand/" + "\(imgURL!)"
            }
            cell.cellImage.sd_setImageWithURL(NSURL(string: imgURL!), placeholderImage: nil)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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



