//
//  UILabel+VerticalAlign.swift
//  Swift2.0Study
//
//  Created by zhcpeng on 15/10/21.
//  Copyright © 2015年 Beijing HuiMai Online Network Technology Co., Ltd. All rights reserved.
//

import UIKit

//public func alignTop() {
//    
//}

class UILabelVerticalAlign : UILabel {
    
    override func alignTop() {
        
//        let fontSize = self.text.sizeWitha
//        String
//        NSTextAlignment
        CGSize fontSize =[self.text sizeWithFont:self.font];
        double finalHeight = fontSize.height *self.numberOfLines;
        double finalWidth =self.frame.size.width;//expected width of label
        CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
        int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
        for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n"];
    }
    
    override func alignBottom() {
        
    }
    
}
