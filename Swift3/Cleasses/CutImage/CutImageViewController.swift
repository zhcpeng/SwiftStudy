//
//  CutImageViewController.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/7/5.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

class CutImageViewController: UIViewController {

    private let imageView1: UIImageView = UIImageView()
    private let imageView2: UIImageView = UIImageView()
    private let slider: UISlider = UISlider()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        slider.minimumValue = 0
        slider.maximumValue = 5
        slider.value = 2.5
        slider.reactive.controlEvents(.valueChanged).observeValues { [weak self](slider) in
            guard let weakSelf = self else { return }
            weakSelf.imageView2.image = weakSelf.cutImage(slider.value)
        }
        slider.frame = CGRect(x: 50, y: 150, width: 200, height: 50)

        imageView1.image = UIImage(named: "backimage")
        imageView1.frame = CGRect(x: 100, y: 200, width: 103, height: 14)

        imageView2.frame = imageView1.frame
        imageView2.contentMode = .left

        view.addSubview(slider)
        view.addSubview(imageView1)
        view.addSubview(imageView2)

        imageView2.image = cutImage(2.5)



        let button = UIButton()
        button.setTitle("fjks ahd liahjdilac moxmfis lenvjg khcmhgi uryghmc", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .left
        button.frame = CGRect(x: 50, y: 250, width: 200, height: 100)
        button.backgroundColor = UIColor.red
        view.addSubview(button)
    }

    private func cutImage(_ value: Float) -> UIImage? {
        guard value > 0.1 else { return nil }
        guard let image = UIImage(named: "cutimage"), let cgRefImage = image.cgImage, let cutRefImage = cgRefImage.cropping(to: CGRect(x: 0, y: 0, width: image.size.width * CGFloat(value) / 5 * image.scale, height: image.size.height * image.scale)) else { return nil }
        let result = UIImage(cgImage: cutRefImage, scale: image.scale, orientation: image.imageOrientation)
        return result
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
