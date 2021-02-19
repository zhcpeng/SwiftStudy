//
//  SwiftGlobalFunction.swift
//  SwiftStudy
//
//  Created by zhcpeng on 15/7/15.
//  Copyright (c) 2015年 zhcpeng. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let iPhoneX = (CGSize(width: 1125, height: 2436).equalTo(UIScreen.main.currentMode!.size))
var kNavigationBarHeight: CGFloat { return iPhoneX ? 88 : 64 }

public func kUIColor (_ color: UInt32) -> UIColor{
    let redComponent = (color & 0xFF0000) >> 16
    let greenComponent = (color & 0x00FF00) >> 8
    let blueComponent = color & 0x0000FF
    let resultcolor : UIColor! = UIColor(red: CGFloat(redComponent) / 255.0, green: CGFloat(greenComponent) / 255.0, blue: CGFloat(blueComponent) / 255.0, alpha: 1)
    return resultcolor
}



//主字体颜色 0x666666
let kColorMain = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)
//次要字体颜色 0x999999
let kColorSecondary = UIColor(red: 99/255.0, green: 99/255.0, blue: 99/255.0, alpha: 1)
//不可用字体颜色 0xdddddd
let kColorEnable  = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)



