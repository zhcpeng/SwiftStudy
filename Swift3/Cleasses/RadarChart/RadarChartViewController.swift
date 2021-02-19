//
//  RadarChartViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/6/15.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

/// Swift 雷达图
class RadarChartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var config = XCRRadarConfig()
        config.speraLineColor = UIColor(red: 0.71, green: 0.72, blue: 0.73, alpha: 1.00)
        config.layerFillColor = UIColor.white
        config.layerBoardColor = UIColor(red: 0.71, green: 0.72, blue: 0.73, alpha: 1.00)
        config.valueDrawFillColorList = [UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 0.2)]
        config.valueBoardFillColorList = [UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1.00)]
        config.descList = ["111", "222", "333", "444", "555", "666", "777", "888"]
        config.valueList = [[8,7,6,5,9,4,10,2]]
        let radarView = XCRRadarView.init(CGRect(x: 20, y: 150, width: 300, height: 300), config: config)
        view.addSubview(radarView)
        radarView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
