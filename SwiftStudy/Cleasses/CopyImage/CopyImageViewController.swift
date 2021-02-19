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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let pboard = UIPasteboard.general;
        if let image = pboard.image {
            imageView.image = image
            button.isEnabled = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.saveAction()
            }
        } else {
            print("No Image")
            button.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
    @objc func saveAction() {
        if let image = imageView.image {
            ImageManager.shared.saveImage(image)
        }
    }


}
