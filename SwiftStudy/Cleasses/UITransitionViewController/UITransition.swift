//
//  UITransitionViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/3/6.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

/// 下滑动画关闭

class XCRPhotosTransition :NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return UIApplication.shared.statusBarOrientationAnimationDuration
//        return 2
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let container = transitionContext.containerView
        
        let initFrame = transitionContext.initialFrame(for: fromVC)
        let finalFrame = initFrame.offsetBy(dx: 0, dy: kScreenHeight)
        
        container.addSubview(toVC.view)
        container.bringSubviewToFront(fromVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = finalFrame
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    } 
}

class XCRInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var panRecognizer: UIPanGestureRecognizer? {
        didSet{
            oldValue?.removeTarget(self, action: #selector(panGestureRecognizer(_:)))
        }
    }
    
    weak var viewController: UIViewController? {
        didSet{
            if let vc = viewController {
                panRecognizer = UIPanGestureRecognizer()
                panRecognizer!.addTarget(self, action: #selector(panGestureRecognizer(_:)))
                /// 使用RAC会造成内存泄漏！！！
//                panRecognizer.reactive.stateChanged.observeValues { [weak self](gestureRecognizer) in
//                    guard let strongSelf = self else { return }
//                    let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
//                    let progress = translation.y / vc.view.bounds.height
//                    switch gestureRecognizer.state{
//                    case .began:
//                        vc.dismiss(animated: true, completion: nil)
//                    case .changed:
//                        strongSelf.update(progress)
//                    default:
//                        if(progress > 0.4){
//                            strongSelf.finish()
//                        }else{
//                            strongSelf.cancel()
//                        }
//                    }
//                }
                vc.view.addGestureRecognizer(panRecognizer!)
            }
        }
    }
    
    @objc private func panGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let vc = self.viewController else { return }
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        var progress = translation.y / vc.view.bounds.height
        progress = min(1, max(0, progress))
        switch gestureRecognizer.state{
        case .began:
            vc.dismiss(animated: true, completion: nil)
        case .changed:
            update(progress)
        default:
            if(progress > 0.4){
                finish()
            }else{
                cancel()
            }
        }
    }
}


class XCRPhotoDismissManager: NSObject, UIViewControllerTransitioningDelegate {
    
    static let share: XCRPhotoDismissManager = XCRPhotoDismissManager()
    
    var interactiveTransition: XCRInteractiveTransition = XCRInteractiveTransition()
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XCRPhotosTransition() as UIViewControllerAnimatedTransitioning
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
}
