//
//  StretchView.swift
//  Swift3
//
//  Created by ZhangChunpeng on 16/12/28.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

import ReactiveCocoa
import ReactiveSwift

class StretchView: UIView {
    
    weak var scrollView : UIScrollView?
    
    var stretchEnable : Bool = false

    private(set) var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "0.jpg")
        return imageView
    }()
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
//        if stretchEnable , let scrollView = scrollView {
//            let y : Property<CGFloat> = scrollView.contentOffset.y
//            print(y)
////            scrollView.reactive.values(forKeyPath: "contentOffset").single()
//            
//            
//            stretchStart(scrollView)
//        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Method
    private func stretchStart(_ scrollView : UIScrollView) {
        let y = scrollView.contentOffset.y
        if y < 0 {
            var frame = self.frame
//            frame.origin.y = y
//            frame.size.height = -y
            self.frame = CGRect.init(x: 0, y: y, width: frame.size.width, height: frame.size.height + -y)
//            self.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        }
    }
    
}
