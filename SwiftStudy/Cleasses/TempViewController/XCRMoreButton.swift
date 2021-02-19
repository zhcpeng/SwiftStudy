//
//  XCRMoreButton.swift
//  XCRKit
//
//  Created by 胡晓玲 on 2018/2/8.
//

import UIKit

/// 图片在前、文字在后
public class XCRMoreButton: UIButton {
    public override func layoutSubviews() {
        super.layoutSubviews()
        if let imageView = imageView {
            let size = self.intrinsicContentSize
            let x = self.bounds.width * 0.5
            titleLabel?.frame.origin.x = x - size.width * 0.5
            imageView.frame.origin.x = x + size.width * 0.5 - imageView.frame.width
        }
    }

    public override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + titleEdgeInsets.left + titleEdgeInsets.right + imageEdgeInsets.left + imageEdgeInsets.right
        return CGSize(width: width, height: size.height)
    }
}

