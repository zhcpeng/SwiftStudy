//
//  SwiftyJSONViewCell.swift
//  Swift2.0Study
//
//  Created by zhcpeng on 15/10/21.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

class SwiftyJSONViewCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!/*{
        didSet{
            print("cellImage setimg")
        }
    }*/
    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = .None
    }
 

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
