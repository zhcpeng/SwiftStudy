//
//  UIButton.swift
//  XCRKit
//
//  Created by zhcpeng on 2017/9/7.
//
//

import UIKit
import ObjectiveC



extension UIButton {

//    private static var touchExtendInsetKey: Void?
    
    private static var touchExtendInsetKey = "touchExtendInsetKey"

    /// 扩大按钮点击区域 如UIEdgeInsets(top: -50, left: -50, bottom: -10, right: -10)将点击区域上下左右各扩充50
    public var touchExtendInset: UIEdgeInsets {
        get {
//            if let value = objc_getAssociatedObject(self, #function) {
            if let value = objc_getAssociatedObject(self, UIButton.touchExtendInsetKey) {
                var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
                (value as AnyObject).getValue(&edgeInsets)
                return edgeInsets
            } else {
                return UIEdgeInsets.zero
            }
        }
        set {
            objc_setAssociatedObject(self, UIButton.touchExtendInsetKey, NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            objc_setAssociatedObject(self, #selector(touchExtendInset), NSValue(uiEdgeInsets: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if touchExtendInset == .zero || isHidden || !isEnabled {
            super.point(inside: point, with: event)
        }
        var hitFrame = bounds.inset(by: touchExtendInset)
        hitFrame.size.width = max(hitFrame.size.width, 0)
        hitFrame.size.height = max(hitFrame.size.height, 0)
        return hitFrame.contains(point)
    }
}

extension UIButton {

    /// XCRKit: Set a background color for the button.
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: state)
    }
}
