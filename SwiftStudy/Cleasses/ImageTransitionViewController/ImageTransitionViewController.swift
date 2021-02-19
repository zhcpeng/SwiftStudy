//
//  ImageTransitionViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/9/5.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class ImageTransitionViewController: UIViewController {

    private lazy var modelTransitioningDelegate = PhotosBrowerAnimationDelegate()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "1234.jpg")
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.frame = CGRect.init(x: 0, y: 100, width: 60, height: 60)
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        imageView.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func imageTap() {
        let vc = PhotosBrowerViewController()
        vc.totalCount = 1
        vc.currentIndex = 0
        vc.frameList = [imageView.frame]
        vc.dataSource = [""]
//        vc.transitioningDelegate = modelTransitioningDelegate
        present(vc, animated: true, completion: nil)
    }

}
