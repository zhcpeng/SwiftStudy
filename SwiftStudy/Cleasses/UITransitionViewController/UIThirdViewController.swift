//
//  UIThirdViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/3/7.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class UIThirdViewController: UIViewController, UIViewControllerTransitioningDelegate {

    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.red
        button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
            self?.dismiss(animated: true, completion: nil)
        })
        return button
    }()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        if #available(iOS 9.3, *) {
            return .lightContent
        } else {
            return .default
        }
//        return .lightContent
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        transitioningDelegate = self
        
        let panRecognizer = UIPanGestureRecognizer()
        /// 使用RAC会造成内存泄漏
        panRecognizer.addTarget(self, action: #selector(panGestureRecognizer(_:)))
        view.addGestureRecognizer(panRecognizer)
    }


    deinit {
        print("\(#file):\(#function)")
    }
    
    @objc private func panGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        var progress = translation.y / view.bounds.height
        progress = min(1, max(0, progress))
//        print(progress)
//        print(gestureRecognizer.state.rawValue)
        switch gestureRecognizer.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
            dismiss(animated: true, completion: nil)
        case .changed:
            interactiveTransition?.update(progress)
        default:
            if(progress > 0.4){
                interactiveTransition?.finish()
            }else{
                interactiveTransition?.cancel()
            }
            interactiveTransition = nil
            
            UIView.animate(withDuration: 0.5, animations: { 
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
        }
    }
    
    var interactiveTransition: UIPercentDrivenInteractiveTransition?
    
    var transition: XCRPhotosTransition = XCRPhotosTransition()
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XCRPhotosTransition() as UIViewControllerAnimatedTransitioning
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }

}
