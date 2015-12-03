//
//  ViewController.swift
//  Swift2.0Study
//
//  Created by zhcpeng on 15/10/20.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.view.backgroundColor = UIColor.redColor();
        
//        let myImage : UIImageView = UIImageView.init();
//        myImage.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight)
//        myImage.contentMode = .Center
//        self.view.addSubview(myImage)
//        myImage.sd_setImageWithURL(NSURL(string: "http://g.hiphotos.baidu.com/image/pic/item/0bd162d9f2d3572c1f99bed58813632762d0c3bb.jpg"), placeholderImage: nil)
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
            Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            let rootListVC :RootListViewController = RootListViewController()
            self.navigationController?.pushViewController(rootListVC, animated: true)
            }
        
        
    }

    @IBAction func btnGoNext(sender: UIButton) {
        let rootListVC :RootListViewController = RootListViewController()
        self.navigationController?.pushViewController(rootListVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

