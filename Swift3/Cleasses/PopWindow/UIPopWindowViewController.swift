//
//  UIPopWindowViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/4/17.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit
//import QuartzCore

class UIPopWindowViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    fileprivate lazy var deleteButton: UIButton = {
        let deleteButton = UIButton(type: .custom)
        deleteButton.setTitle("按钮", for: .normal)
        deleteButton.backgroundColor = UIColor.red
//        deleteButton.addTarget(self, action: #selector(onDelButtonClicked), for: .touchUpInside)
        deleteButton.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](x) in
            self?.popWindows()
            })
        return deleteButton
    }()
    
    
    private(set) lazy var addCoverButton: UIButton = {
        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 20, y: 350, width: 100, height: 40)
        
        let borderLayer = CAShapeLayer()
        borderLayer.bounds = button.bounds
        borderLayer.position = button.center
        borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: 6).cgPath
        borderLayer.lineWidth = 1
        borderLayer.lineDashPattern = [5,3]
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.red.cgColor
        borderLayer.lineJoin = CAShapeLayerLineJoin.round
        
        button.layer.addSublayer(borderLayer)
        button.backgroundColor = UIColor.gray
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(deleteButton)
        deleteButton.frame = CGRect.init(x: 50, y: 200, width: 100, height: 40)

        
        
        let borderView = UIShapeView()
        view.addSubview(borderView)
        borderView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(350)
            make.height.equalTo(40)
        }
 
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) {
//            borderView.showShapeLayer = false
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func popWindows() {
//        UIAlertController
//        UIModalPresentationPopover
        
        let vc = UIViewController()
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 40))
        view.backgroundColor = UIColor.green
        vc.view = view
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize.init(width: 100, height: 40)

        vc.popoverPresentationController?.sourceView = self.view
        vc.popoverPresentationController?.sourceRect = CGRect.init(x: 200, y: 200, width: 100, height: 40)
        vc.popoverPresentationController?.delegate = self
        vc.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection() //.any
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}


extension UIView {
    func addShapeLayer() {
        let borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(roundedRect: CGRect(x: -1, y: -1, width: frame.size.width + 2, height: frame.size.height + 2), cornerRadius: 4).cgPath
        borderLayer.lineWidth = 1
        borderLayer.lineDashPattern = [5,3]
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.red.cgColor
        
        self.layer.addSublayer(borderLayer)
    }
}

class UIShapeView: UIView {
    
    var showShapeLayer: Bool = true {
        didSet{
            shapeLayer.isHidden = !showShapeLayer
        }
    }
    
    private lazy var shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: -1, y: -1, width: self.frame.size.width + 2, height: self.frame.size.height + 2), cornerRadius: 4).cgPath
        layer.lineWidth = 1
        layer.lineDashPattern = [5,3]
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.red.cgColor
        return layer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        shapeLayer.path = UIBezierPath(roundedRect: CGRect(x: -1, y: -1, width: self.frame.size.width + 2, height: self.frame.size.height + 2), cornerRadius: 4).cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
