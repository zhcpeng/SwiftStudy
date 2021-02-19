//
//  UIViewExtension.swift
//  Swift4
//
//  Created by zhcpeng on 2019/7/22.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import Foundation

extension UIView {
//    func addSubviews(_ views: [UIView]) {
//        views.forEach(addSubview(_:$0))
//    }
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach(addSubview)
    }
}
