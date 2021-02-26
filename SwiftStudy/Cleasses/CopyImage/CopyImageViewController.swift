//
//  CopyImageViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2020/12/23.
//  Copyright © 2020 zhcpeng. All rights reserved.
//

import UIKit

class CopyImageViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        return button
    }()
    
    private var changeCount: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.checkImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkImage), name: UIApplication.didBecomeActiveNotification, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func saveAction() {
        if let image = imageView.image {
            ImageManager.shared.saveImage(image)
        }
    }
    
    @objc func checkImage() {
        let pboard = UIPasteboard.general;
        print(pboard.changeCount)
        if let image = pboard.image, pboard.changeCount != changeCount {
            imageView.image = image
//            pboard.image = nil
            button.isEnabled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.saveAction()
            }
        } else {
            print("No Image")
            button.isEnabled = false
        }
        
        changeCount = pboard.changeCount
    }


}
