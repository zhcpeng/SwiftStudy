//
//  XCRCycleView.swift
//  Swift3
//
//  Created by ZhangChunPeng on 2017/9/25.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

/// 圆圈进度条
class XCRCycleView: UIView {
    
    var progress: Float = 0 {
        didSet{
            drawCircle(CGFloat(progress))
        }
    }
    
    var title: String = "" {
        didSet{
            titleLabel.text = title
        }
    }
    
    private var contentView: UIView = UIView()
    private var progressLabel: UILabel = UILabel()
    private var cycleView: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var shapeLayer = CAShapeLayer()
    private let startAngle = -(CGFloat.pi * 0.5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
        commontInit()
        changeTheme()

        layoutIfNeeded()
        
        drawCircle(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawCircle(_ percent: CGFloat) {
        progressLabel.text = String(format: "%2.f%%", percent * 100)

        let rect = CGRect(x: 0, y: 64, width: 64, height: 64)
        UIGraphicsBeginImageContext(rect.size)
        guard let content = UIGraphicsGetCurrentContext() else { return }
        content.setLineWidth(2)
        content.setStrokeColor(UIColor.white.cgColor)
        content.addArc(center: cycleView.center, radius: 31, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        content.strokePath()

        content.setStrokeColor(UIColor.red.cgColor)
        let endAngle = CGFloat.pi * 2 * percent + startAngle
        content.addArc(center: cycleView.center, radius: 31, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        content.strokePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        cycleView.image = image
    }
    
    private func initUI() {
        progressLabel.textAlignment = .center
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
    }
    
    private func commontInit() {
        addSubview(contentView)
        contentView.snp.makeConstraints{ (make) in
            make.center.equalToSuperview()
            make.width.equalTo(64)
            make.height.equalTo(96)
        }
        contentView.addSubview(cycleView)
        contentView.addSubview(progressLabel)
        contentView.addSubview(titleLabel)
        cycleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(64)
        }
        progressLabel.snp.makeConstraints { (make) in
            make.center.equalTo(cycleView)
            make.left.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    private func changeTheme() {
        progressLabel.textColor = UIColor.white
        titleLabel.textColor = UIColor.white
    }
    

}
