//
//  XCRRaderView.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/6/15.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// 雷达图
class XCRRadarView: UIView {

    var config: XCRRadarConfig

    private var chartOrigin: CGPoint = CGPoint.zero
    private var chartRadius: CGFloat = 0
    private var drawPointArray: [[CGPoint]] = []
    private var baseDrawPointArray: [[CGPoint]] = []

    // MARK: - LifeCycle
    init(_ frame: CGRect, config: XCRRadarConfig) {
        self.config = config
        super.init(frame: frame)

        chartRadius = (frame.size.height - 60) / 2
        chartOrigin = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show() {
        guard !config.valueList.isEmpty else {
            fatalError("请输入数据")
        }

        configBaseViewDataArray()
        configDrawingData()
        drawBaseView()
        drawValueView()
    }

    // MARK: - Private Methods
    /// 初始化点数组
    private func configDrawingData() {
        if config.valueList.isEmpty {
            return
        }
        let perAngle = CGFloat.pi * 2 / CGFloat(config.descList.count)
        let perfect: CGFloat = max(0, config.perfectNumber)
        config.valueList.forEach { (valueArray) in
            var cacheArray: [CGPoint] = []
            for (index, value) in valueArray.enumerated() {
                let value = min(perfect, value)
                let index = CGFloat(index)
                let x: CGFloat = chartOrigin.x + value / perfect * chartRadius * sin(index * perAngle)
                let y: CGFloat = chartOrigin.y - value / perfect * chartRadius * cos(index * perAngle)
                let cachePoint = CGPoint(x: x, y: y)
                cacheArray.append(cachePoint)
            }
            drawPointArray.append(cacheArray)
        }
    }

    private func configBaseViewDataArray() {
        baseDrawPointArray.removeAll()
        let perLength: CGFloat = chartRadius / CGFloat(config.layerCount)
        let perAngle: CGFloat = CGFloat.pi * 2 / CGFloat(config.descList.count)
        for i in 0..<config.layerCount {
            var cacheArray: [CGPoint] = []
            let cacheLength = CGFloat(i+1) * perLength
            for (index, value) in config.descList.enumerated() {
                let index = CGFloat(index)
                let cachePoint = CGPoint(x: chartOrigin.x + cacheLength * sin(index * perAngle), y: chartOrigin.y - cacheLength * cos(index * perAngle))
                cacheArray.append(cachePoint)
                if i == 0 {
                    let width = sizeOf(value, maxSize: CGSize(width: 200, height: 20), font: config.descTextFont).width
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 20))
                    label.font = config.descTextFont
                    label.textColor = config.descTextColor
                    label.text = value
                    label.center = CGPoint(x: chartOrigin.x + (chartRadius + width / 2 + 5) * sin(index * perAngle), y: chartOrigin.y - (chartRadius + 20 / 2 + 5) * cos(index * perAngle))
                    self.addSubview(label)
                }
            }
            baseDrawPointArray.append(cacheArray)
        }
    }

    private func drawBaseView() {
        // 每层的边、背景色
        for cacheArray in baseDrawPointArray.reversed() {
            let shapeLayer = CAShapeLayer()
            let path = UIBezierPath()
            for (index, point) in cacheArray.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = config.layerFillColor.cgColor
            shapeLayer.strokeColor = config.layerBoardColor.cgColor
            shapeLayer.lineWidth = (1 / UIScreen.main.scale)
            self.layer.addSublayer(shapeLayer)
        }
        // 原点到角的线
        let shapeLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.close()
        path.move(to: chartOrigin)
        guard let cacheArray = baseDrawPointArray.last else { return }
        for point in cacheArray {
            path.addLine(to: point)
            path.move(to: chartOrigin)
        }
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = config.speraLineColor.cgColor
        shapeLayer.lineWidth = (1 / UIScreen.main.scale)
        self.layer.addSublayer(shapeLayer)
    }

    private func drawValueView() {
        // 雷达图
        if drawPointArray.isEmpty { return }
        for (i,cacheArray) in drawPointArray.enumerated() {
            let path = UIBezierPath()
            for (index, point) in cacheArray.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.close()
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.borderWidth = 1.0;
            var cacheColor = UIColor.red.withAlphaComponent(0.3)
            if config.valueDrawFillColorList.count > i {
                cacheColor = config.valueDrawFillColorList[i]
            }
            shapeLayer.fillColor = cacheColor.cgColor
            if config.valueBoardFillColorList.count > i {
                cacheColor = config.valueBoardFillColorList[i]
            }
//            shapeLayer.borderColor = cacheColor.cgColor
            shapeLayer.strokeColor = cacheColor.cgColor
            self.layer.addSublayer(shapeLayer)
        }
    }

    private func sizeOf(_ string: String, maxSize: CGSize, font: UIFont) -> CGSize {
        return (string as NSString).boundingRect(with: maxSize, options: [.usesFontLeading, .usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
}

/// 雷达图配置
struct XCRRadarConfig {
    /// 值数组
    var valueList: [[CGFloat]] = []
    /// 顶点描述文字颜色
    var descList: [String] = []
    /// 分层数
    var layerCount: ushort = 5
    /// 每层的填充颜色
    var layerFillColor: UIColor = UIColor(white: 0.5, alpha: 0.3)
    /// 每层的边线颜色
    var layerBoardColor: UIColor = UIColor(white: 0.5, alpha: 0.3)
    /// 中心到顶点的边颜色
    var speraLineColor: UIColor = UIColor.white
    /// 满分
    var perfectNumber: CGFloat = 10
    /// 文本大小
    var descTextFont: UIFont = UIFont.systemFont(ofSize: 14)
    /// 文本颜色
    var descTextColor: UIColor = UIColor.black
    /// 填充颜色
    var valueDrawFillColorList: [UIColor] = []
    /// 填充轮廓的颜色数组
    var valueBoardFillColorList: [UIColor] = []
}
