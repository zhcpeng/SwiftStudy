//
//  PhotosBrowerAnimationDelegate.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/9/5.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

fileprivate let TransitionDuration: TimeInterval = 1

class PhotosBrowerAnimationDelegate: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresentAnimationing: Bool = true
}

extension PhotosBrowerAnimationDelegate {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TransitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresentAnimationing ? presentViewAnimation(transitionContext) : dismissViewAnimation(transitionContext)
    }

    func presentViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let destinationController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? PhotosBrowerViewController else { return }
        transitionContext.containerView.addSubview(destinationController.view)


//        guard let cell = destinationController.collectionView.cellForItem(at: IndexPath(item: destinationController.currentIndex, section: 0)) as? PhotosBrowerCollectionViewCell else { return }
        guard let image = UIImage(named: "1234.jpg") else {
            return
        }
        let annimateView = UIImageView()
        annimateView.image = image
        annimateView.contentMode = .scaleAspectFill
        annimateView.clipsToBounds = true

//        let originFrame = destinationController.collectionView.convert(cell.frame, to: UIApplication.shared.keyWindow)
        let originFrame = destinationController.frameList.first ?? CGRect.zero
        annimateView.frame = originFrame
        transitionContext.containerView.addSubview(annimateView)
        destinationController.view.alpha = 0

        let endFrame = coverImageFrameToFullScreenFrame(image)

        UIView.animate(withDuration: TransitionDuration * 0.7, animations: {
            annimateView.frame = endFrame
        }) { (finished) in
            transitionContext.completeTransition(true)
            UIView.animate(withDuration: TransitionDuration * 0.3, animations: {
                destinationController.view.alpha = 1
            }, completion: { (_) in
                annimateView.removeFromSuperview()
            })
        }
    }

    func dismissViewAnimation(_ transitionContext: UIViewControllerContextTransitioning) {
        guard let destinationController = transitionContext.viewController(forKey: .from) as? PhotosBrowerViewController else { return }
        guard let cell = destinationController.collectionView.cellForItem(at: IndexPath(item: destinationController.currentIndex, section: 0)) as? PhotosBrowerCollectionViewCell else { return }
        let contentView = transitionContext.containerView

        let annimateView = UIImageView()
        annimateView.image = cell.imageView.image
        annimateView.contentMode = .scaleAspectFill
        annimateView.clipsToBounds = true
        annimateView.frame = coverImageFrameToFullScreenFrame(cell.imageView.image)
        contentView.addSubview(annimateView)

        let endFrame = destinationController.currentIndex < destinationController.frameList.count ? destinationController.frameList[destinationController.currentIndex] : destinationController.frameList.last ?? CGRect.zero
        cell.isHidden = true
        UIView.animate(withDuration: 1, animations: {
            annimateView.frame = endFrame
            destinationController.view.alpha = 0
        }, completion: { (finished) in
            cell.isHidden = false
            annimateView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

    func coverImageFrameToFullScreenFrame(_ image: UIImage?) -> CGRect {
        guard let image = image else  { return CGRect.zero }

        let w:CGFloat = UIScreen.main.bounds.width
        let h:CGFloat = w * image.size.height / image.size.width
        let x:CGFloat = 0
        let y:CGFloat = (UIScreen.main.bounds.height - h) * 0.5;
        return CGRect(x: x, y: y, width: w, height: h)
    }


}
