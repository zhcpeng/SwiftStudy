//
//  RetinaDrawRectViewController.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/3/17.
//

import UIKit

class RetinaDrawRectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let v = RetinaDrawRectView(frame: CGRect(x: 30, y: 100, width: 300, height: 300))
        self.view.addSubview(v)
        
        self.view.backgroundColor = UIColor.white
    }
    


}
