//
//  TouchMoveViewController.swift
//  Swift4
//
//  Created by 张春鹏 on 2019/1/4.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import UIKit

class TouchMoveViewController: UIViewController {
    
    private let backView : UIView = {
        let view = UIView(frame: CGRect.init(x: 50, y: 100, width: 300, height: 300));
        view.backgroundColor = UIColor.green
        return view
    }()
    private let cycleView: UIView = {
        let view = UIView(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        view.backgroundColor = UIColor.red
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15;
        return view
    }()
    private var currentCenter: CGPoint = CGPoint.zero {
        didSet{
            cycleView.center = currentCenter;
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(backView);
        self.view.addSubview(cycleView);
        currentCenter = CGPoint(x: 50, y: 250);
        
        let move = UIPanGestureRecognizer()
        move.maximumNumberOfTouches = 1
        move.addTarget(self, action: #selector(panGest(_:)))
        self.view.addGestureRecognizer(move)
    }
    
    @objc func panGest(_ gr: UIPanGestureRecognizer) {
        if gr.state == .changed {
            let point = gr.location(in: self.view)
            if point.x < 50 || point.x > 350 /*|| point.y < 0 || point.y > 300*/ {
                return;
            }
            let center = CGPoint(x: CGFloat(Int(point.x - 50) / 20 * 20 + 50), y: 250)
            if center != currentCenter {
                currentCenter = center
            }
        }
    }

}
