//
//  XCRToastView.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/7/25.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

enum XCRToastViewType {
    case failure
    case success
}

private let duration: TimeInterval = 1.5


class XCRToastView: UIView {

    /**
     显示toast弹窗的类方法
     - parameters:
        - text: 展示的问题
        - type: toast类型，默认为 .failure
     */
    public class func show(_ text: String, type: XCRToastViewType = .failure) {
        let toast = XCRToastView(frame: UIScreen.main.bounds)
        toast.textLabel.text = text
        toast.type = type
        toast.updateViewConstraints(type, isForce: true)
        toast.show()
    }

    private var type: XCRToastViewType = .failure

    private var contentView: UIView = UIView()
    private var imageView: UIImageView = UIImageView()
    private var textLabel: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        initUI()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func show() {
        guard let view = UIApplication.shared.keyWindow else { return }
//        for subview in view.subviews where subview.isKind(of: XCRToastView.self) {
//            NSObject.cancelPreviousPerformRequests(withTarget: subview)
//            break
//        }
        view.addSubview(self)
        contentView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.contentView.alpha = 1
        }
        self.perform(#selector(hidden), with: nil, afterDelay: duration)
    }

    @objc private func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentView.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
//            if let view = UIApplication.shared.keyWindow {
//                for subview in view.subviews where subview.isKind(of: XCRToastView.self) {
//                    subview.removeFromSuperview()
//                }
//            }
        }
    }

    // MARK: - Private Method
    private func initUI() {
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false

        contentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 2

        imageView.image = UIImage(named: "success_image")
        imageView.isHidden = true

        textLabel.numberOfLines = 2
        textLabel.font = UIFont.systemFont(ofSize: 15)
        textLabel.textColor = UIColor.white
        textLabel.lineBreakMode = .byTruncatingTail
        textLabel.textAlignment = .center
    }

    private func commonInit() {
        addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(252)
            make.height.equalTo(72)
        }
    }

    private func updateViewConstraints(_ type: XCRToastViewType, isForce: Bool = false) {
        if isForce || type != self.type {
            switch type {
            case .failure:
                imageView.snp.removeConstraints()
                textLabel.snp.remakeConstraints({ (make) in
                    make.edges.equalToSuperview().inset(12)
                })
                textLabel.preferredMaxLayoutWidth = 228
            case .success:
                imageView.isHidden = false
                imageView.snp.remakeConstraints({ (make) in
                    make.centerY.equalToSuperview()
                    make.right.equalTo(textLabel.snp.left).offset(-10)
                })
                textLabel.snp.remakeConstraints({ (make) in
                    make.centerY.equalToSuperview()
                    make.centerX.equalToSuperview().offset(12)
                    make.left.greaterThanOrEqualToSuperview().offset(42)
                    make.right.lessThanOrEqualToSuperview().offset(-12)
                })
                textLabel.preferredMaxLayoutWidth = 184
                textLabel.setContentCompressionResistancePriority(UILayoutPriority.required, for: .horizontal)
            }
        }
    }

}
