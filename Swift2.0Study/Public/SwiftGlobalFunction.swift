//
//  SwiftGlobalFunction.swift
//  SwiftStudy
//
//  Created by zhcpeng on 15/7/15.
//  Copyright (c) 2015年 zhcpeng. All rights reserved.
//

import UIKit

//import SwiftyJSON

let IS_IOS7 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0

let kScreenWidth = UIScreen.mainScreen().bounds.size.width
let kScreenHeight = UIScreen.mainScreen().bounds.size.height

public func kCurrentHeight(H:CGFloat) -> CGFloat{
    return (H * (kScreenWidth) / 320.0)
}
public func kGetCurrentHeight(W:CGFloat,H:CGFloat) -> CGFloat{
    return (((kScreenWidth) - (320 - W)) * H / W)
}

public func kUIColor (color: UInt32) -> UIColor{
    let redComponent = (color & 0xFF0000) >> 16
    let greenComponent = (color & 0x00FF00) >> 8
    let blueComponent = color & 0x0000FF
    let resultcolor : UIColor! = UIColor(red: CGFloat(redComponent) / 255.0, green: CGFloat(greenComponent) / 255.0, blue: CGFloat(blueComponent) / 255.0, alpha: 1)
    return resultcolor
}

public func SwiftClassFromString(className: String) -> UIViewController? {
    if  let appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String {
        let classStringName = "_TtC\(appName.characters.count)\(appName)\(className.characters.count)\(className)"
        let  cls: AnyClass? = NSClassFromString(classStringName)
        assert(cls != nil, "class not found,please check className")
        if let viewClass = cls as? UIViewController.Type {
            let view = viewClass.init()
            return view
        }
    }
    return nil;
}

//public func SwiftSetValueWithJSON(model:AnyObject , json : JSON){
//    
//}


//主字体颜色 0x666666
let kColorMain = UIColor(colorLiteralRed: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)
//次要字体颜色 0x999999
let kColorSecondary = UIColor(colorLiteralRed: 99/255.0, green: 99/255.0, blue: 99/255.0, alpha: 1)
//不可用字体颜色 0xdddddd
let kColorEnable  = UIColor(colorLiteralRed: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1)



