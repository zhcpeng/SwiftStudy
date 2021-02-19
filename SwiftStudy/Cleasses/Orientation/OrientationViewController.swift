//
//  OrientationViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/9/7.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

//import ReactiveCocoa

class OrientationViewController: UIViewController {
    
    
    

	fileprivate lazy var imageView: UIImageView = {
		let view = UIImageView()
		// view.backgroundColor = UIColor.redColor()
//		view.image = UIImage.init(named: "1234.jpg")
        view.image = UIImage.init(named: "05.jpg")
		view.contentMode = .scaleAspectFit
//        view.layer.borderColor = UIColor.redColor().CGColor
//        view.layer.borderWidth = 1
		return view
	}()
    
    fileprivate lazy var topView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return view
    }()

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

//		self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        self.view.clipsToBounds = false
        
        
		self.view.addSubview(imageView)
//        imageView.frame = self.view.bounds
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        NotificationCenter.default.reactive.notifications(forName: UIDevice.orientationDidChangeNotification, object: nil).observe { notification in
            self.rotate()
        }
        
//		NotificationCenter.default.rac_addObserverForName(NSNotification.Name.UIDeviceOrientationDidChange, object: nil).subscribeNext { [weak self](_) in
//			self?.rotate()
//		}

//        return NotificationCenter.default
//            .reactive
//            .notifications(forName: name, object: base)
//            .take(during: lifetime)
//            .map { ($0.object as! UITextView).text!
        
                
                
        
//        UIApplication.sharedApplication().setStatusBarOrientation(.LandscapeLeft, animated: false)
//        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .None)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	fileprivate func rotate() {
		UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
//			self.imageView.transform = rotationTransform()
//            self.imageView.bounds = rotationAdjustedBounds()
            self.view.transform = rotationTransform()
            self.view.bounds = rotationAdjustedBounds()
		}) { (_) in
//            print(self.imageView.frame)
		}
	}

	override var prefersStatusBarHidden : Bool {
		return true
	}

}
