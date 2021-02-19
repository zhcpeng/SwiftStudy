//
//  XCRGradientColorView.swift
//  XCar
//
//  Created by ZhangChunpeng on 16/7/8.
//  Copyright © 2016年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

/// 渐变色的view
class XCRGradientColorView: UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        // 使用RGB模式的颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        // 颜色空间，如果使用RGB颜色空间则4个数字一组表示一个颜色
//        let colors : [CGFloat] = [0,0,0,0.1,0,0,0,1]
        let colors : [CGFloat] = [0,0,0,0,0,0,0,1]
        // locations 代表2个颜色的区域分布（0～1） ，如果需要均匀分布需要传入NULL
//        let locations :[CGFloat] = [0,1]
//        let gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 2);
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colors, locations: nil, count: 2);
        
        // 第三个参数表示起始点，第四个参数表示结束点
        // 最后一个参数如果设置kCGGradientDrawsAfterEndLocation表示结束点后面的区域使用渐变填充，设置kCGGradientDrawsBeforeStartLocation表示起始点前面的区域使用渐变色填充，设置为0表示只填充起始点和结束点中间区域
        context?.drawLinearGradient(gradient!, start: CGPoint(x: 0, y: self.bounds.size.height), end: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height), options: .drawsAfterEndLocation);
    }

}
