//
//  DoubelColumnView.swift
//  Swift2Study
//
//  Created by zhcpeng on 15/11/13.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class DoubelColumnView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var oldPrice: UILabelStrikeThrougj!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var name: UILabel!
    
    var model : ProductModel!{
        didSet{
            imageView.sd_setImageWithURL(NSURL(string: model.app_special_pic), placeholderImage: nil)
            price.text = model.price
            oldPrice.text = model.mktprice
            oldPrice.strikeThroughEnabled = true
            discount.text = model.discount_rate
            name.text = model.goods_name
//            NSLog("%@",String(self.frame))
        }
    }

    override func awakeFromNib() {
//        self.layer.masksToBounds = false;
//        self.layer.shadowPath = UIBezierPath.init(rect: self.bounds).CGPath
//        self.layer.cornerRadius = 3; // if you like rounded corners
//        self.layer.shadowOffset = CGSizeMake(0, 0);
//        self.layer.shadowRadius = 5;
//        self.layer.shadowOpacity = 0.5;
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
