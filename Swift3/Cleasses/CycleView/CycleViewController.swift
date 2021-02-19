//
//  CycleViewController.swift
//  Swift3
//
//  Created by ZhangChunPeng on 2017/9/25.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class CycleViewController: UIViewController {
    
    private var cycleView: XCRCycleView = XCRCycleView()

    private var progressView: UISlider = UISlider()

    private var rightButton: XCRRightImageButtonView = XCRRightImageButtonView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.gray

        cycleView.title = "视频压缩中"
        view.addSubview(cycleView)
        cycleView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(100)
        }
        view.layoutIfNeeded()
        cycleView.progress = 0.6

        view.addSubview(progressView)
        progressView.value = 0.6
        progressView.reactive.controlEvents(.valueChanged).observeValues({ [weak self](x) in
            self?.cycleView.progress = x.value
        })
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(cycleView.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }


        view.addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.equalTo(90)
            make.height.equalTo(40)
        }
        rightButton.backgroundColor = UIColor.red
        rightButton.button.setTitle("全部照片", for: .normal)
        rightButton.imageView.image = UIImage(named: "discover_narbar_button_h")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
