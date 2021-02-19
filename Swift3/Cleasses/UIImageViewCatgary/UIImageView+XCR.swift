//
//  UIImageView+XCR.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/7/18.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

private var privateShowHighlighted : Bool = false
private var privateHighlightedView : UIView?

extension UIImageView {
    
    public var showHighlighted : Bool {
        get{
            return (objc_getAssociatedObject(self, &privateShowHighlighted) as? Bool)!
        }
        set{
            objc_setAssociatedObject(self, &privateShowHighlighted, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            if !self.subviews.contains(self.highlightedView) {
                self.highlightedView = UIView()
                self.addSubview(self.highlightedView)
                self.highlightedView.frame = self.bounds
            }
            if newValue {
                self.highlightedView.backgroundColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 0.5)
            }else{
                self.highlightedView.backgroundColor = UIColor.clear
            }
        }
    }
    
    fileprivate var highlightedView : UIView {
        get{
            let obj = objc_getAssociatedObject(self, &privateHighlightedView)
            if obj == nil {
                return UIView()
            }
            return obj as! UIView
        }
        set{
            objc_setAssociatedObject(self, &privateHighlightedView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
