//
//  XCRRightImageButtonView.swift
//  XCar
//
//  Created by ZhangChunPeng on 2017/9/26.
//  Copyright © 2017年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

class XCRRightImageButtonView: UIView {

    private var contentView: UIView = UIView()
    private(set) var button: UIButton = UIButton(type: .custom)
    private(set) var imageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initUI()
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func initUI() {
//        button.touchExtendInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)

        imageView.contentMode = .center
    }

    private func commonInit() {
        addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.addSubview(button)
        contentView.addSubview(imageView)
        button.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
//            make.right.equalToSuperview().offset(-10)
        }
        imageView.snp.makeConstraints { (make) in
            make.centerY.right.equalToSuperview()
            make.left.equalTo(button.snp.right).offset(6)
        }
        imageView.setContentHuggingPriority(UILayoutPriority.required, for: .horizontal)
    }

}
