//
//  PhotosAlbumViewController.swift
//  Swift3
//
//  Created by ZhangChunPeng on 2017/12/20.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit
import Photos

enum XCRCollectionScrollDirection {
    case none
    case up
    case down
    case left
    case right
}

class PhotosAlbumViewController: UIViewController {

    var selectedPhotos: [XCRPhotosSelectedModel] = []
    private var isSeletcedCell: Bool = true
    private var isReversed: Bool = false

    private var itemList: PHFetchResult<PHAsset>?
    fileprivate lazy var imageManager: PHCachingImageManager = PHCachingImageManager()
    fileprivate let padding: CGFloat = 2
    fileprivate lazy var width: CGFloat = floor((kScreenWidth - self.padding * 4 - self.padding * 3) / 4)
    fileprivate let scale = UIScreen.main.scale
    fileprivate lazy var assetGridThumbnailSize: CGSize = CGSize(width: self.width * self.scale, height: self.width * self.scale)
    fileprivate lazy var imageRequestOptions: PHImageRequestOptions = {
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true
        imageRequestOptions.resizeMode = .fast
        imageRequestOptions.deliveryMode = .fastFormat
        return imageRequestOptions
    }()
    fileprivate lazy var options: PHFetchOptions = {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        options.includeAssetSourceTypes = .typeUserLibrary
        return options
    }()
    private var previousPreheatRect = CGRect.zero
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.width, height: self.width)
        layout.minimumInteritemSpacing = self.padding
        layout.minimumLineSpacing = self.padding

        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotosAlbumViewCell.self, forCellWithReuseIdentifier: "PhotosAlbumViewCell")
        collectionView.contentInset = UIEdgeInsets(top: self.padding * 2, left: self.padding * 2, bottom: self.padding * 2, right: self.padding * 2)
        collectionView.backgroundColor = UIColor.white
        collectionView.allowsMultipleSelection = true
        collectionView.delaysContentTouches = true

        return collectionView
    }()
    private var authorized: Bool = false

    private var m_lastAccessed: IndexPath?

    // 拖动
    private var tempMoveView: UIView?
    private var edgeTimer: CADisplayLink?
    private var scrollDirection: XCRCollectionScrollDirection = .none


    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            DispatchQueue.main.async(execute: {
                self.authorized = true
                self.itemList = PHAsset.fetchAssets(with: .image, options: nil)
                self.collectionView.reloadData()
            })
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.authorized = true
                        self.itemList = PHAsset.fetchAssets(with: .image, options: nil)
                        self.collectionView.reloadData()
                    }
                default:
                    break
                }
            })
        case .denied, .restricted:
            break
        default:
            break
        }

        let pan = UIPanGestureRecognizer.init()
        pan.addTarget(self, action: #selector(panGesture(_ :)))
        view.addGestureRecognizer(pan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UIScrollView
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard authorized == true else { return }
        updateCachedAssets()
    }

    // MARK: Asset Caching
    fileprivate func resetCachedAssets() {
        imageManager.stopCachingImagesForAllAssets()
        previousPreheatRect = .zero
    }

    fileprivate func updateCachedAssets() {
        // Update only if the view is visible.

        // The preheat window is twice the height of the visible rect.
        let preheatRect = collectionView.bounds.insetBy(dx: 0, dy: -0.5 * collectionView.bounds.height)

        // Update only if the visible area is significantly different from the last preheated area.
        let delta = abs(preheatRect.midY - previousPreheatRect.midY)
        guard delta > collectionView.bounds.height / 3 else { return }

        // Compute the assets to start caching and to stop caching.
        let (addedRects, removedRects) = differencesBetweenRects(previousPreheatRect, preheatRect)
        let addedAssets = addedRects.flatMap { indexPathsForElements(in: $0) }.map { (item) -> PHAsset in
            return itemList![item]
        }

        let removedAssets = removedRects.flatMap { indexPathsForElements(in: $0) }.map { (item) -> PHAsset in
            return itemList![item]
        }

        // Update the assets the PHCachingImageManager is caching.
        imageManager.startCachingImages(for: addedAssets,
                                        targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil)
        imageManager.stopCachingImages(for: removedAssets,
                                       targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil)

        // Store the preheat rect to compare against in the future.
        previousPreheatRect = preheatRect
    }

    fileprivate func differencesBetweenRects(_ old: CGRect, _ new: CGRect) -> (added: [CGRect], removed: [CGRect]) {
        if old.intersects(new) {
            var added = [CGRect]()
            if new.maxY > old.maxY {
                added += [CGRect(x: new.origin.x, y: old.maxY,
                                 width: new.width, height: new.maxY - old.maxY)]
            }
            if old.minY > new.minY {
                added += [CGRect(x: new.origin.x, y: new.minY,
                                 width: new.width, height: old.minY - new.minY)]
            }
            var removed = [CGRect]()
            if new.maxY < old.maxY {
                removed += [CGRect(x: new.origin.x, y: new.maxY,
                                   width: new.width, height: old.maxY - new.maxY)]
            }
            if old.minY < new.minY {
                removed += [CGRect(x: new.origin.x, y: old.minY,
                                   width: new.width, height: new.minY - old.minY)]
            }
            return (added, removed)
        } else {
            return ([new], [old])
        }
    }

    func indexPathsForElements(in rect: CGRect) -> [Int] {
        guard let allLayoutAttributes = collectionView.collectionViewLayout.layoutAttributesForElements(in: rect) else {
            return []
        }
        return allLayoutAttributes.map { $0.indexPath.item }
    }

    // MARK: 选中
    private var startPoint: CGPoint = CGPoint.zero
    private var movePoint: CGPoint = CGPoint.zero
    /// 选中所有
    @objc private func panGesture(_ gest: UIGestureRecognizer) {
        switch gest.state {
        case .began:
            startPoint = gest.location(ofTouch: 0, in: collectionView)
            tempMoveView = UIView()
            tempMoveView?.backgroundColor = UIColor.clear
            tempMoveView?.frame = CGRect(x: 0, y: 0, width: width, height: width)
            tempMoveView?.center = startPoint
            view.addSubview(tempMoveView!)
            startEdgeTimer()
            let startRect = CGRect(origin: startPoint, size: CGSize(width: 1, height: 1))
            if let startIndexPath = collectionView.collectionViewLayout.layoutAttributesForElements(in: startRect)?.first?.indexPath {
                var contentPhoto = false
                for model in selectedPhotos where model.representedAssetIdentifier == itemList![startIndexPath.item].localIdentifier {
                    contentPhoto = true
                    break
                }
                isSeletcedCell = !contentPhoto
            } else {
                isSeletcedCell = true
            }
        case .changed:
            movePoint = gest.location(ofTouch: 0, in: collectionView)
            tempMoveView?.center = movePoint
            selectedCell(gest)
        default:
            stopEdgeTimer()
            tempMoveView?.removeFromSuperview()
            resetGesture()
        }
    }

    // MARK: 滑动相关
    private func startEdgeTimer() {
        edgeTimer = CADisplayLink(target: self, selector: #selector(edgeScroll))
        edgeTimer?.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    private func stopEdgeTimer() {
        edgeTimer?.invalidate()
        edgeTimer = nil
    }
    private func setCollectionScrollDirection() {
        scrollDirection = .none
        guard let view = tempMoveView else { return }
        let size = collectionView.bounds.size
        let contentOffset = collectionView.contentOffset
        if view.center.y - contentOffset.y < view.bounds.size.height && contentOffset.y >= -kNavigationBarHeight {
            scrollDirection = .up
        }
        if size.height + contentOffset.y - view.center.y < view.bounds.size.height / 2 && collectionView.bounds.size.height + contentOffset.y < collectionView.contentSize.height {
            scrollDirection = .down
        }
    }
    @objc private func edgeScroll() {
        setCollectionScrollDirection()
        switch scrollDirection {
        case .up:
            collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y - 4), animated: false)
            if let view = tempMoveView {
                view.center = CGPoint(x: view.center.x, y: view.center.y - 4)
            }
        case .down:
            collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: collectionView.contentOffset.y + 4), animated: false)
            if let view = tempMoveView {
                view.center = CGPoint(x: view.center.x, y: view.center.y + 4)
            }
        default:
            break
        }
    }
    private func resetGesture() {
        gestureContentIndexPathCount = -1
        startPoint = CGPoint.zero
        movePoint = CGPoint.zero
    }
    private var gestureContentIndexPathCount: Int = -1
    private func selectedCell(_ gest: UIGestureRecognizer) {
        /// 从头到尾包含的全部选择
        let startRect = CGRect(origin: startPoint, size: CGSize(width: 1, height: 1))
        let endRect = CGRect(origin: movePoint, size: CGSize(width: 1, height: 1))
        guard let startItem = collectionView.collectionViewLayout.layoutAttributesForElements(in: startRect)?.first?.indexPath.item, let endItem = collectionView.collectionViewLayout.layoutAttributesForElements(in: endRect)?.first?.indexPath.item else { return }
        isReversed = endItem < startItem
        let minItem = min(startItem, endItem)
        let maxItem = max(startItem, endItem)
        var indexPaths: [IndexPath] = []
        for item in minItem...maxItem {
            indexPaths.append(IndexPath(item: item, section: 0))
        }
        if gestureContentIndexPathCount == indexPaths.count {
            return
        }
        gestureContentIndexPathCount = indexPaths.count
        if isReversed {
            indexPaths = indexPaths.reversed()
        }
        for indexPath in indexPaths {
            var contentPhoto = false
            for model in selectedPhotos where model.representedAssetIdentifier == itemList![indexPath.item].localIdentifier {
                contentPhoto = true
                break
            }
            if isSeletcedCell {
                // 选中，选中时忽略已选中的
                if !contentPhoto {
                    let newModel = XCRPhotosSelectedModel()
                    newModel.image = (collectionView.cellForItem(at: indexPath) as? PhotosAlbumViewCell)?.imageView.image
                    newModel.representedAssetIdentifier = itemList![indexPath.item].localIdentifier
                    newModel.phAsset = itemList?[indexPath.item]
                    selectedPhotos.append(newModel)
                    collectionView.reloadItems(at: [indexPath])
                }
            } else {
                if contentPhoto {
                    for (index, model) in selectedPhotos.enumerated() where model.representedAssetIdentifier == itemList![indexPath.item].localIdentifier {
                        selectedPhotos.remove(at: index)
                        break
                    }
                }
            }
        }
        if !isSeletcedCell {
            collectionView.reloadData()
        }
    }
}

extension PhotosAlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosAlbumViewCell", for: indexPath) as! PhotosAlbumViewCell
        cell.controller = self
        imageManager.requestImage(for: itemList![indexPath.item], targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: imageRequestOptions) { (result, _) in
            cell.imageView.image = result
        }
        cell.representedAssetIdentifier = itemList![indexPath.item].localIdentifier
        for (index, model) in selectedPhotos.enumerated() where model.representedAssetIdentifier == itemList![indexPath.item].localIdentifier {
            cell.selected(true, animate: true, index: index)
            break
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosAlbumViewCell else { return }
        var contentPhoto = false
        for (index, model) in selectedPhotos.enumerated() where model.representedAssetIdentifier == cell.representedAssetIdentifier {
            selectedPhotos.remove(at: index)
            collectionView.reloadData()
            contentPhoto = true
            break
        }
        if !contentPhoto {
            let newModel = XCRPhotosSelectedModel()
            newModel.image = cell.imageView.image
            newModel.representedAssetIdentifier = itemList?[indexPath.item].localIdentifier ?? ""
            newModel.phAsset = itemList?[indexPath.item]
            selectedPhotos.append(newModel)
            collectionView.reloadItems(at: [indexPath])
        }
    }
}
