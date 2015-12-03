//
//  DoubelColumnCell.swift
//  Swift2Study
//
//  Created by zhcpeng on 15/11/13.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class DoubelColumnCell: UITableViewCell {
    
    private var view1 :DoubelColumnView!
    private var view2 :DoubelColumnView!
    
    var model1 : ProductModel!{
        didSet{
            if view1 == nil{
                view1 = NSBundle.mainBundle().loadNibNamed("DoubelColumnView", owner: self, options: nil)[0] as! DoubelColumnView
                self.addSubview(view1)
                dispatch_async(dispatch_get_main_queue(), {
                    var frame1 = self.view1.frame
                    frame1.origin.x = 10
                    frame1.origin.y = 5
                    frame1.size.width = (kScreenWidth - 30) * 0.5
                    frame1.size.height = kGetCurrentHeight(145, H: 145) + 80 - 10
                    self.view1.frame = frame1
                    
                    self.view1.layer.masksToBounds = false;
                    self.view1.layer.shadowPath = UIBezierPath.init(rect: self.view1.bounds).CGPath
                    self.view1.layer.cornerRadius = 3; // if you like rounded corners
                    self.view1.layer.shadowOffset = CGSizeMake(0, 0);
                    self.view1.layer.shadowRadius = 3;
                    self.view1.layer.shadowOpacity = 0.2;
                })
            }
            view1.model = model1
        }
    }
    
    var model2 : ProductModel!{
        didSet{
            if view2 == nil{
                view2 = NSBundle.mainBundle().loadNibNamed("DoubelColumnView", owner: self, options: nil)[0] as! DoubelColumnView
                self .addSubview(view2)
                dispatch_async(dispatch_get_main_queue(), {
                    var frame2 = self.view2.frame
                    frame2.origin.x = kScreenWidth * 0.5 + 5
                    frame2.origin.y = 5
                    frame2.size.width = (kScreenWidth - 30) * 0.5
                    frame2.size.height = kGetCurrentHeight(145, H: 145) + 80 - 10
                    self.view2.frame = frame2
                    
                    self.view2.layer.masksToBounds = false;
                    self.view2.layer.shadowPath = UIBezierPath.init(rect: self.view2.bounds).CGPath
                    self.view2.layer.cornerRadius = 3; // if you like rounded corners
                    self.view2.layer.shadowOffset = CGSizeMake(0, 0);
                    self.view2.layer.shadowRadius = 3;
                    self.view2.layer.shadowOpacity = 0.2;
                })
                
            }
            view2.model = model2
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
