//
//  PhotosBrowerViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/8/30.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

protocol PhotosBrowerViewControllerDelegate: NSObjectProtocol {
//    func numberOfPhotosInPhotosBrowser(_ photoBrower: PhotosBrowerViewController) -> Int
    func photosBrowser(_ photosBrowser: PhotosBrowerViewController, placeholderImageForIndex index: Int) -> UIImage?
//    func photosBrowser(_ photosBrowser: PhotosBrowerViewController, urlForIndex index: Int) -> String
//    func photosBrowser(_ photosBrowser: PhotosBrowerViewController, frameForIndex index: Int) -> CGRect
}

extension PhotosBrowerViewControllerDelegate {
    func photosBrowser(_ photosBrowser: PhotosBrowerViewController, placeholderImageForIndex index: Int) -> UIImage? {
        return nil
    }
}

class PhotosBrowerViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate {

    weak var delegate: PhotosBrowerViewControllerDelegate?

    var currentIndex: Int = 0
    var totalCount: Int = 0
    var dataSource: [String] = []
    var placeholderImage: [UIImage?] = []
    var frameList: [CGRect] = [CGRect.zero]

    private(set) lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.view.frame.size

        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosBrowerCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosBrowerCollectionViewCell")
        collectionView.panGestureRecognizer.require(toFail: self.panRecognizer)
        return collectionView
    }()

    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let panRecognizer = UIPanGestureRecognizer()
        panRecognizer.addTarget(self, action: #selector(panGestureRecognizer(_:)))
        panRecognizer.delegate = self
        return panRecognizer
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        view.addSubview(collectionView)

//        self.transitioningDelegate = animatedTransitioning
//        self.transitioningDelegate = self
        view.addGestureRecognizer(panRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosBrowerCollectionViewCell", for: indexPath) as! PhotosBrowerCollectionViewCell
        cell.imageView.image = UIImage(named: "1234.jpg")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool{
        return true

        return false
    }

    // MARK: - UIViewControllerTransitioningDelegate
    @objc private func panGestureRecognizer(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view)
        var progress = translation.y / view.bounds.height
        progress = min(1, max(0, progress))
        switch gestureRecognizer.state {
        case .began:
            interactiveTransition = UIPercentDrivenInteractiveTransition()
//            animatedTransitioning.type = .dismiss
            dismiss(animated: true, completion: nil)
        case .changed:
            interactiveTransition?.update(progress)
        default:
            if(progress > 0.1) {
                interactiveTransition?.finish()
            } else {
                interactiveTransition?.cancel()
            }
            interactiveTransition = nil
        }
    }

    private var interactiveTransition: UIPercentDrivenInteractiveTransition?
    private var animatedTransitioning: PhotosBrowerAnimationDelegate = PhotosBrowerAnimationDelegate()

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning.isPresentAnimationing = true
        return (animatedTransitioning as UIViewControllerAnimatedTransitioning)
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransitioning.isPresentAnimationing = false
        return (animatedTransitioning as UIViewControllerAnimatedTransitioning)
    }

    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }

}
