//
//  ImageBrowerViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/2/16.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

import Photos

class ImageBrowerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: kScreenWidth, height: kScreenHeight)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: self.flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollsToTop = false
        collectionView.isPagingEnabled = true
        collectionView.isDirectionalLockEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageBrowerCollectionViewCell.self, forCellWithReuseIdentifier: "ImageBrowerCollectionViewCell")
        return collectionView
    }()
    
    private lazy var itemList : PHFetchResult<PHAsset> = PHAsset.fetchAssets(with: self.options)
    fileprivate lazy var imageManager: PHCachingImageManager = PHCachingImageManager()
    fileprivate lazy var imageRequestOptions: PHImageRequestOptions = {
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true
        imageRequestOptions.resizeMode = .fast
        imageRequestOptions.deliveryMode = .highQualityFormat
        return imageRequestOptions
    }()
    fileprivate lazy var options: PHFetchOptions = {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return options
    }()
    
    private var currentIndex: Int = Int.max
    
    private var rotating: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
//        navigationController?.navigationBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Do any additional setup after loading the view.
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        var assets : [PHAsset] = []
        for i in 0..<itemList.count {
            assets.append(itemList.object(at: i))
        }
        imageManager.startCachingImages(for: assets,
                                        targetSize: self.view.frame.size, contentMode: .aspectFill, options: nil)
        
//        scrollViewDidEndDecelerating(collectionView)
    }

    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        print("\(#function)")
        rotating = true
        let page = collectionView.contentOffset.x / collectionView.bounds.width
        let width: CGFloat = toInterfaceOrientation.isPortrait ? min(kScreenWidth, kScreenHeight) : max(kScreenWidth, kScreenHeight)
        let height: CGFloat = toInterfaceOrientation.isPortrait ? max(kScreenWidth, kScreenHeight) : min(kScreenWidth, kScreenHeight)
        let contentWidth = width * CGFloat(itemList.count)
        
        UIView.animate(withDuration: duration, animations: {
            self.collectionView.contentSize = CGSize(width: contentWidth, height: height)
            self.collectionView.setContentOffset(CGPoint(x: width * page, y: 0), animated: false)
            self.collectionView.collectionViewLayout.invalidateLayout()
        })
    }
    /*
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("\(#function)")
//        self.rotating = true
//        let page = collectionView.contentOffset.x / collectionView.bounds.width
//        let contentWidth = size.width * CGFloat(itemList.count)
//        coordinator.animate(alongsideTransition: { (_) in
//            self.collectionView.contentSize = CGSize(width: contentWidth, height: size.height)
//            self.collectionView.setContentOffset(CGPoint(x: size.width * page, y: 0), animated: false)
//            self.collectionView.collectionViewLayout.invalidateLayout()
//        }) { (_) in
//            self.rotating = false
//        }
    
        super.viewWillTransition(to: size, with: coordinator)
        
//        let page = collectionView.contentOffset.x / collectionView.bounds.width
//        let contentWidth = size.width * CGFloat(itemList.count)
//        
//        self.collectionView.contentSize = CGSize(width: contentWidth, height: size.height)
//        self.collectionView.setContentOffset(CGPoint(x: size.width * page, y: 0), animated: false)
//        self.collectionView.collectionViewLayout.invalidateLayout()
        
//        super.viewWillTransition(to: size, with: coordinator)
        
    }
    */
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        rotating = false
        print("\(#function)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageBrowerCollectionViewCell", for: indexPath) as! ImageBrowerCollectionViewCell
        imageManager.requestImage(for: itemList[indexPath.item], targetSize: self.view.bounds.size, contentMode: .aspectFill, options: imageRequestOptions) { (result, info) in
                cell.image = result
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("will display: \(indexPath.item)")
        guard currentIndex != indexPath.item, rotating == false else { return }
        guard let imageCell = cell as? ImageBrowerCollectionViewCell else { return }
        imageManager.requestImage(for: itemList[indexPath.item], targetSize: self.view.bounds.size, contentMode: .aspectFill, options: imageRequestOptions) { (result, info) in
            imageCell.image = result
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        currentIndex = indexPath.item
//        print("end display: \(currentIndex)")
//    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        print("end display: \(currentIndex)")
    }

}
