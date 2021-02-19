//
//  CALayerViewController.swift
//  Swift3
//
//  Created by ZhangChunPeng on 2017/10/11.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class CALayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let color1 = UIColor.white.withAlphaComponent(0.2)
//        let colors = [UIColor.clear.cgColor, color1.cgColor, UIColor.clear.cgColor]
//        let locations: [NSNumber] = [0.2, 0.5, 0.8]
//
//        let line = CAGradientLayer.init()
////        line.colors = [UIColor.black.cgColor]
////        line.locations = [0,1]
//        line.colors = colors
//        line.locations = locations
//        line.startPoint = CGPoint.zero
//        line.endPoint = CGPoint.init(x: 0, y: 1)
//        line.frame = CGRect.init(x: 100, y: 100, width: 10, height: 50)
//
//
//
//        view.layer.addSublayer(line)

        let line = CALayer()
        line.backgroundColor = UIColor.red.cgColor
        line.frame = CGRect.init(x: 100, y: 100, width: 10, height: 100)
        view.layer.addSublayer(line)





//        if let dict = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
//            if let totalCount = dict[.systemSize], let total = totalCount as? Double {
//                let t = total / (1024 * 1024 * 1024)
//                print("total: \(t)")
//            }
//            if let freeCount = dict[.systemFreeSize], let free = freeCount as? Double {
//                let f = free / (1024 * 1024 * 1024)
//                print("total: \(f)")
//            }
//        }



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
