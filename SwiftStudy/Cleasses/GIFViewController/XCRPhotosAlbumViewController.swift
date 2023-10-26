//
//  XCRPhotosAlbumViewController.swift
//  XCar
//
//  Created by ZhangChunpeng on 16/8/29.
//  Copyright © 2016年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

import Photos
import ReactiveCocoa
import ReactiveSwift
import MobileCoreServices
//import MBProgressHUD
//import YYText
import AVFoundation

//swiftlint:disable empty_count
/// 选中的照片model
class XCRPhotosSelectedModel: NSObject {
	/// 照片唯一标识符
	var representedAssetIdentifier = ""
	/// 相册原图
	var image: UIImage?
	/// 编辑后的图片
	var editImage: UIImage?
	/// 照片路径
	var phAsset: PHAsset?
	/// 是否选中
	var isSelected: Bool = true
}

@objc protocol XCRPhotosAlbumDelegate: NSObjectProtocol {
	// 相册选择界面 - 完成选择
	@objc optional func photosAlbum(_ photosAlbum: XCRPhotosAlbumViewController, didFinish photos: [XCRPhotosSelectedModel])
	// /// 相册选择界面 - 图片改变
	// optional func photoAlbum(photosAlbum: XCRPhotosAlbumViewController, didChangePhotos photos: [XCRPhotosSelectedModel])
	// 相册选择界面 - 选中的某一张图 （如果不是需要请不要实现此方法）
	@objc optional func photoAlbum(_ photosAlbum: XCRPhotosAlbumViewController, didSelectedPhoto photo: UIImage)
	// 相册选择界面 - 拍照完成
	@objc optional func photoAlbum(_ photosAlbum: XCRPhotosAlbumViewController, didFinishTakePhoto photo: UIImage)
}

let kXCRPhotosAlbumViewControllerDidChangePhotosNotification = "kXCRPhotosAlbumViewControllerDidChangePhotosNotification"

/// 相册浏览
class XCRPhotosAlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPhotoLibraryChangeObserver {

	// MARK: - Property
	/// 图片选择器delegate
	weak var delegate: XCRPhotosAlbumDelegate?

	/// 选中的图片
	var selectedPhotos: [XCRPhotosSelectedModel] = [] {
		didSet {
            DispatchQueue.main.async {
                self.selectedPhotosChanged(self.selectedPhotos.count)
                NotificationCenter.default.post(name: Notification.Name(rawValue: kXCRPhotosAlbumViewControllerDidChangePhotosNotification), object: self)
            }
		}
	}

	/// 选择图片上限
	var selectedPhotosLimit: Int = 9

	/// 是否显示cell选中框
	var showCellSelected: Bool = true

	/// 是否显示拍照按钮
	var showTakePhoto: Bool = true

	// 201601027:新增拍照展示图片编辑界面需求
	/// 是否需要拍照编辑界面
	var allowsEditing: Bool = false

	/// 可选的图片最小宽度，Int?型
	var minImageWidth: Int?

	/// 大图预览页最大图片宽度（获取原图过多时可能造成内存崩溃）
	var maxImageWidthInPreview: Int?

	fileprivate lazy var albumsList: [PHFetchResult<PHAsset>] = []
	fileprivate lazy var imageManager: PHCachingImageManager = PHCachingImageManager()
	fileprivate let padding: CGFloat = 8
	fileprivate lazy var width: CGFloat = (kScreenWidth - 30 - self.padding * 3) / 4
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
        if #available(iOS 9, *) {
            options.includeAssetSourceTypes = .typeUserLibrary
        }
		return options
	}()

	private var authorized: Bool = false
	fileprivate lazy var albumsListTitle: [String] = {
		var list = ["全部照片", "最近添加", "个人收藏", "全景照片"]
		if #available(iOS 9, *) {
			list.append("自拍")
		}
		return list
	}()
	fileprivate lazy var currentAlbumsIndex: Int = 0
	private var previousPreheatRect = CGRect.zero

	fileprivate lazy var tableView: UITableView = {
		let tableView = UITableView(frame: self.view.bounds, style: .plain)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = 74
		tableView.register(XCRPhotosAlbumTableViewCell.self, forCellReuseIdentifier: "XCRPhotosAlbumTableViewCell.identifier")
		tableView.separatorStyle = .none
		tableView.contentInset = UIEdgeInsets(top: 7, left: 0, bottom: 7, right: 0)
		tableView.scrollsToTop = false
		return tableView
	}()

	fileprivate lazy var collecionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: self.width, height: self.width)
		layout.minimumInteritemSpacing = self.padding
		layout.minimumLineSpacing = self.padding

		let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
		collectionView.delegate = self
		collectionView.dataSource = self
//		collectionView.emptyDataSetSource = self
//		collectionView.emptyDataSetDelegate = self
		collectionView.register(XCRPhotosAlbumViewCell.self, forCellWithReuseIdentifier: "XCRPhotosAlbumViewCell.identifier")
		collectionView.register(XCRPhotosTakePicturesCell.self, forCellWithReuseIdentifier: "XCRPhotosTakePicturesCell.identifier")
		collectionView.contentInset = UIEdgeInsets(top: 14, left: 15, bottom: 14, right: 15)
		return collectionView
	}()

	fileprivate lazy var navigationBarButton: UIButton = {
		let button = UIButton(type: .custom)
		button.frame = CGRect(x: 0, y: 0, width: 90, height: 44)
		button.setTitle("全部照片", for: .normal)
		button.setImage(UIImage(named: "btn_image_blackdown"), for: .normal)
		button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
		// button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 41, bottom: 0, right: -31)
		button.adjustsImageWhenHighlighted = false
		button.isExclusiveTouch = true
//		button.titleLabel?.font = UIFont.normal
		button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
			self?.controlAlbumTableView()
		})
		button.imageView?.snp.makeConstraints({ (make) in
			make.centerY.equalTo(button)
            make.right.equalTo(button)
		})
		return button
	}()

	fileprivate lazy var rightNavButton: UIButton = {
		let rightNavButton = UIButton(type: .custom)
        rightNavButton.sizeToFit()
		rightNavButton.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
			self?.navigationController?.dismiss(animated: true, completion: nil)
		})
		return rightNavButton
	}()

	fileprivate var tableViewIsOpen: Bool = false {
		didSet {
//			if tableViewIsOpen {
//                navigationBarButton.setImage(XCRTheme.image(named: "btn_image_blackup"), for: .normal)
//			} else {
//                navigationBarButton.setImage(XCRTheme.image(named: "btn_image_blackdown"), for: .normal)
//			}
		}
	}

	fileprivate lazy var tableViewContentView: UIView = {
		let view = UIView()
		view.isHidden = true
		return view
	}()
	fileprivate lazy var tableViewContentGestureView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		view.alpha = 0
		let gest = UITapGestureRecognizer(target: self, action: #selector(controlAlbumTableView))
		view.addGestureRecognizer(gest)
		return view
	}()

	fileprivate lazy var previewButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setTitle("预览", for: .normal)
		button.isEnabled = false
//		button.titleLabel?.font = UIFont.normal
//		button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
//			if let weakSelf = self {
//				let vc = XCRPhotosPreviewViewController()
//				vc.photosAlbumController = weakSelf
//				vc.type = .selectedPhotos
//				vc.minImageWidth = weakSelf.minImageWidth
//				weakSelf.navigationController?.pushViewController(vc, animated: true)
//			}
//		})

		return button
	}()

	fileprivate lazy var finishButton: UIButton = {
		let button = UIButton(type: .custom)
		button.setTitle("下一步", for: .normal)
		button.isEnabled = false
//		button.titleLabel?.font = UIFont.normal
//		button.touchExtendInset = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
		button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
			// NSNotificationCenter.default.postNotificationName(XCRTopicAddCommentPicNotification, object: nil)
			self?.finishChooesePhoto()
		})
        button.sizeToFit()
		return button
	}()

//	fileprivate lazy var bottomView: UIView = UIView()
//	fileprivate lazy var bottomLineView: UIView = UIView()
	/// 当次操作之前选中照片的数量（为优化性能，只能当删除照片时才reloadData）
	fileprivate var selectedPhotosCount = 0

	/// 没有权限view
	fileprivate lazy var photoDeniedView: UIView = {
		let view = UIView()
		view.addSubview(self.photoDeniedLabel)
		self.photoDeniedLabel.snp.makeConstraints({ (make) in
			make.centerX.equalTo(view)
			make.centerY.equalTo(view).offset(-30)
		})
		return view
	}()
	fileprivate lazy var photoDeniedLabel: YYLabel = {
		let label = YYLabel()
		label.numberOfLines = 0
		label.preferredMaxLayoutWidth = kScreenWidth - 100
		return label
	}()

//	/// 加载中
//	fileprivate lazy var emptyView: XCREmptyView = {
//		let emptyView = XCREmptyView()
//		emptyView.type = .noData
//		return emptyView
//	}()

	// MARK: - LifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

		navigationItem.hidesBackButton = true
		navigationItem.titleView = navigationBarButton
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = -5
        navigationItem.leftBarButtonItems = [fixedSpace, UIBarButtonItem(customView: rightNavButton)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: finishButton)
        finishButton.isEnabled = false
		commonInit()
//		theme()
//		NotificationCenter.default.reactive.notifications(forName: Notification.Name.XCRThemeChanged).observe { [weak self] _ in
//			self?.theme()
//		}

		PHPhotoLibrary.shared().register(self)

		switch PHPhotoLibrary.authorizationStatus() {
		case .authorized:
			authorized = true
			// MBProgressHUD.showCustomHUDAddedTo(self.view, animated: true)
			// 这个另起线程是因为该方法太浪费时间
			DispatchQueue.main.async(execute: {
				self.loadAlbums()
				self.collecionView.reloadData()
				// MBProgressHUD.hide(for: self.view, animated: true)
			})
		case .notDetermined:
			PHPhotoLibrary.requestAuthorization({ (status) in
				switch status {
				case .authorized:
					// 这个另起线程是因为当前block不是主线程
					DispatchQueue.main.async(execute: {
						self.authorized = true
						self.loadAlbums()
						self.collecionView.reloadData()
					})
				default:
					DispatchQueue.main.async(execute: {
						self.view.addSubview(self.photoDeniedView)
						self.photoDeniedView.snp.makeConstraints({ (make) in
							make.edges.equalTo(self.view)
						})
					})
				}
			})
		case .denied, .restricted:
			self.view.addSubview(self.photoDeniedView)
			self.photoDeniedView.snp.makeConstraints({ (make) in
				make.edges.equalTo(self.view)
			})
        default:
            break
		}
	}

	deinit {
		PHPhotoLibrary.shared().unregisterChangeObserver(self)
		// 相册浏览界面内存检查完成
		// print("\(#file):\(#function)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: - UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return albumsList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "XCRPhotosAlbumTableViewCell.identifier", for: indexPath) as! XCRPhotosAlbumTableViewCell
		cell.albumTitleLabel.text = albumsListTitle[indexPath.row]
		cell.albumCountLabel.text = String(albumsList[indexPath.row].count)
		if albumsList[indexPath.row].count > 0 {
			let asset = albumsList[indexPath.row][0]
			cell.representedAssetIdentifier = asset.localIdentifier
			imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: imageRequestOptions) { (result, _) in
				if cell.representedAssetIdentifier == asset.localIdentifier {
					cell.albumImage = result
				}
			}
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if currentAlbumsIndex != indexPath.row {
			resetCachedAssets()
			currentAlbumsIndex = indexPath.row
			navigationBarButton.setTitle(albumsListTitle[currentAlbumsIndex], for: .normal)
			collecionView.reloadData()
//			collecionView.scrollToTop(animated: false)
		}
		controlAlbumTableView()
	}

	// MARK: - UICollectionViewDataSource
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard !albumsList.isEmpty else {
			return 0
		}
		return (currentAlbumsIndex == 0 && showTakePhoto) ? albumsList[currentAlbumsIndex].count + 1: albumsList[currentAlbumsIndex].count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if currentAlbumsIndex == 0 && showTakePhoto && indexPath.item == 0 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XCRPhotosTakePicturesCell.identifier", for: indexPath) as! XCRPhotosTakePicturesCell
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XCRPhotosAlbumViewCell.identifier", for: indexPath) as! XCRPhotosAlbumViewCell
			cell.controller = self
			cell.selectedButton.isHidden = !showCellSelected
			let asset = albumsList[currentAlbumsIndex][(currentAlbumsIndex == 0 && showTakePhoto) ? indexPath.item - 1: indexPath.item]
			cell.representedAssetIdentifier = asset.localIdentifier

            if #available(iOS 9.0, *) {
                if let resource = PHAssetResource.assetResources(for: asset).first {
                    cell.isGIF = (resource.uniformTypeIdentifier == (kUTTypeGIF as String))
                }
            } else {
                imageManager.requestImageData(for: asset, options: imageRequestOptions, resultHandler: { (_, dataUTI, _, _) in
                    var isGIF = false
                    if let uti = dataUTI, uti == (kUTTypeGIF as String) {
                        // 是gif图
                        isGIF = true
                    }
                    cell.isGIF = isGIF
                })
            }

			imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: imageRequestOptions) { (result, _) in
				if cell.representedAssetIdentifier == asset.localIdentifier {
					cell.imageView.image = result
					cell.phAsset = asset
				}
			}
			return cell
		}
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
        /*
		if currentAlbumsIndex == 0 && showTakePhoto && indexPath.item == 0 {
			if selectedPhotos.count >= selectedPhotosLimit {
				XCRAlertBanner(style: .failure, position: .top, title: "最多只能添加\(selectedPhotosLimit)张照片哦").show()
				return
			}

			let statue = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
			switch statue {
			case .authorized:
				navigationController?.present(photoPicker, animated: true, completion: nil)
			case .notDetermined:
				AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
					DispatchQueue.main.async(execute: {
						if granted {
							self.navigationController?.present(self.photoPicker, animated: true, completion: nil)
						} else {
							XCRAlertBanner(style: .failure, position: .top, title: "没有权限访问你的相机").show()
						}
					})
				})
			default:
				XCRAlertBanner(style: .failure, position: .top, title: "没有权限访问你的相机").show()
			}
		} else {
			if let delegate = delegate, delegate.responds(to: #selector(XCRPhotosAlbumDelegate.photoAlbum(_: didSelectedPhoto:))) {
				let imageRequestOptions = PHImageRequestOptions()
				imageRequestOptions.isSynchronous = true
				imageRequestOptions.resizeMode = .fast
				imageRequestOptions.deliveryMode = .highQualityFormat
				let asset = albumsList[currentAlbumsIndex][(currentAlbumsIndex == 0 && showTakePhoto) ? indexPath.item - 1: indexPath.item]
				PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: imageRequestOptions) { (result, _) in
					if let resultImage = result {
						delegate.photoAlbum?(self, didSelectedPhoto: resultImage)
					}
				}
				return
			}

			let vc = XCRPhotosPreviewViewController()
			vc.photosAlbumController = self
			vc.type = .photos
			vc.fetchResult = albumsList[currentAlbumsIndex]
			vc.minImageWidth = self.minImageWidth
			navigationController?.pushViewController(vc, animated: true)
			vc.currentIndex = (currentAlbumsIndex == 0 && showTakePhoto) ? indexPath.item - 1: indexPath.item
		}
        */
	}

	/// iOS系统SDK BUG，UIImagePickerController 不会释放，因此创建为全局属性，只创建一次
	fileprivate lazy var photoPicker: UIImagePickerController = {
		let vc = UIImagePickerController()
		vc.sourceType = .camera
		vc.delegate = self
		vc.allowsEditing = self.allowsEditing
		return vc
	}()

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

		let type = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.mediaType)] as! String
		if type == kUTTypeImage as String {
			var resuleImage: UIImage?
			if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
				resuleImage = image
			} else if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
				resuleImage = image
			}
			if let image = resuleImage {
				if let delegate = delegate, delegate.responds(to: #selector(XCRPhotosAlbumDelegate.photoAlbum(_: didFinishTakePhoto:))) {
					picker.dismiss(animated: false, completion: nil)
					delegate.photoAlbum?(self, didFinishTakePhoto: image)
					return
				}
				UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageWriteToSavedPhotosAlbum(_: didFinishSavingWithError: contextInfo:)), nil)
			}
			picker.dismiss(animated: true, completion: nil)
		}
	}

	fileprivate var isFromCamera = false
	fileprivate var tempImage: UIImage?

	// - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
	@objc fileprivate func imageWriteToSavedPhotosAlbum(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo info: [String: AnyObject]) {
		if nil != error {
//			XCRAlertBanner(style: .failure, position: .top, title: "保存失败").show()
		} else {
			isFromCamera = true
			tempImage = image
		}
	}

	// MARK: PHPhotoLibraryChangeObserver
	func photoLibraryDidChange(_ changeInstance: PHChange) {
		DispatchQueue.main.async {
			for i in 0..<self.albumsList.count {
				let detailChange = changeInstance.changeDetails(for: self.albumsList[i])
				// 删除
				if let removedObjects = detailChange?.removedObjects {
					for obj in removedObjects {
						let asset = obj
						for (index, model) in self.selectedPhotos.enumerated() where model.representedAssetIdentifier == asset.localIdentifier {
							self.selectedPhotos.remove(at: index)
						}
					}
				}

				// 添加
				if let insertedObjects = detailChange?.insertedObjects {
					if self.isFromCamera {
						self.isFromCamera = false
						for obj in insertedObjects {
							let asset = obj
							if self.selectedPhotos.count < self.selectedPhotosLimit {
								let model = XCRPhotosSelectedModel()
								model.representedAssetIdentifier = asset.localIdentifier
								model.phAsset = asset
								model.image = self.tempImage
								self.selectedPhotos.append(model)
								self.tempImage = nil
							}
						}
					}
				}

				// 更新
				if let new = detailChange?.fetchResultAfterChanges {
					self.albumsList[i] = new
					if i == self.currentAlbumsIndex {
						self.collecionView.reloadData()
					}
				}
			}
		}
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
		let preheatRect = collecionView.bounds.insetBy(dx: 0, dy: -0.5 * collecionView.bounds.height)

		// Update only if the visible area is significantly different from the last preheated area.
		let delta = abs(preheatRect.midY - previousPreheatRect.midY)
		guard delta > collecionView.bounds.height / 3 else { return }

		// Compute the assets to start caching and to stop caching.
		let (addedRects, removedRects) = differencesBetweenRects(previousPreheatRect, preheatRect)
		let addedAssets = addedRects.flatMap { indexPathsForElements(in: $0) }.map { (item) -> PHAsset in
				var currentItem: Int = item
				if currentAlbumsIndex == 0, showTakePhoto, item > 0 {
					currentItem = item - 1
				}
				return albumsList[currentAlbumsIndex][currentItem]
		}

		let removedAssets = removedRects.flatMap { indexPathsForElements(in: $0) }.map { (item) -> PHAsset in
			var currentItem: Int = item
			if currentAlbumsIndex == 0, showTakePhoto, item > 0 {
				currentItem = item - 1
			}
			return albumsList[currentAlbumsIndex][currentItem]
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
		guard let allLayoutAttributes = collecionView.collectionViewLayout.layoutAttributesForElements(in: rect) else {
			return []
		}
		return allLayoutAttributes.map { $0.indexPath.item }
	}

//	// MARK: - DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
//	func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
//		return emptyView
//	}
//
//	func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
//		if albumsList.isEmpty {
//			return false
//		}
//		return albumsList[currentAlbumsIndex].count == 0
//	}
//
//	func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
//		return true
//	}

	// MARK: - open Method
	func finishChooesePhoto() {
		DispatchQueue.main.async {
			self.delegate?.photosAlbum?(self, didFinish: self.selectedPhotos)
		}
		navigationController?.dismiss(animated: true, completion: nil)
	}

	// MARK: - Private Method
	fileprivate func commonInit() {
		view.addSubview(collecionView)

		collecionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
		}

		view.addSubview(tableViewContentView)
		tableViewContentView.addSubview(tableView)
		tableViewContentView.addSubview(tableViewContentGestureView)
		tableViewContentView.snp.makeConstraints { (make) in
			make.edges.width.equalTo(view)
		}
		tableView.snp.makeConstraints { (make) in
			make.left.top.right.width.equalTo(tableViewContentView)
			make.height.equalTo(0)
		}
		tableViewContentGestureView.snp.makeConstraints { (make) in
			make.left.bottom.right.equalTo(tableViewContentView)
			make.top.equalTo(tableView.snp.bottom)
		}

	}

	// MARK: 加载相册
	fileprivate func loadAlbums() {
		// 全部图片
        let allPhotos = PHAsset.fetchAssets(with: .image, options: options)
		albumsList.append(allPhotos)
		// 最新添加
		let recentlyAdded = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumRecentlyAdded, options: nil)
		let recentlyAddedAsset = PHAsset.fetchAssets(in: recentlyAdded[0], options: nil)
		albumsList.append(recentlyAddedAsset)
		// 个人收藏
		let favorites = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
		let favoritesAsset = PHAsset.fetchAssets(in: favorites[0], options: nil)
		albumsList.append(favoritesAsset)
		// 全景照片
		let panoramas = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumPanoramas, options: nil)
		let panoramasAsset = PHAsset.fetchAssets(in: panoramas[0], options: nil)
		albumsList.append(panoramasAsset)
		// 自拍
		if #available(iOS 9, *) {
			let selfPortraits = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumSelfPortraits, options: nil)
			let selfPortraitsAsset = PHAsset.fetchAssets(in: selfPortraits[0], options: nil)
			albumsList.append(selfPortraitsAsset)
		}
		tableView.reloadData()
	}

	@objc fileprivate func controlAlbumTableView() {
		view.layoutIfNeeded()
		if tableViewIsOpen {
			self.tableView.snp.updateConstraints({ (make) in
				make.height.equalTo(0)
			})
			UIView.animate(withDuration: 0.15, animations: {
				self.view.layoutIfNeeded()
				self.tableViewContentGestureView.alpha = 0
				}, completion: { (_) in
				self.tableViewContentView.isHidden = true
			})
		} else {
			self.tableView.snp.updateConstraints({ (make) in
				make.height.equalTo(self.albumsListTitle.count * 74 + 14)
			})
			UIView.animate(withDuration: 0.15, animations: {
				self.view.layoutIfNeeded()
				self.tableViewContentGestureView.alpha = 1
			})
			self.tableViewContentView.isHidden = false
		}
		tableViewIsOpen = !(tableViewIsOpen)
	}

	fileprivate func selectedPhotosChanged(_ count: Int) {
        finishButton.isEnabled = count > 0
		if selectedPhotosCount > count || navigationController?.visibleViewController != self {
			collecionView.reloadData()
		}
		selectedPhotosCount = count
	}

	// MARK: - Theme
	fileprivate func theme() {
//		collecionView.backgroundColor = UIColor.cFFFFFF_2A3342
//		tableView.backgroundColor = UIColor.cFFFFFF_2A3342
//		navigationBarButton.setTitleColor(UIColor.c44494D_8A99A3, for: .normal)
//		navigationBarButton.setTitleColor(XCRTheme.highlightedTextColor, for: .highlighted)
//		tableViewIsOpen = tableViewIsOpen ? true : false
//		finishButton.setTitleColor(UIColor.c1DA1F2_208BCF, for: .normal)
//		finishButton.setTitleColor(UIColor.c138BD5_1B79B4, for: .highlighted)
//		finishButton.setTitleColor(UIColor.cD1D2D5_45515E, for: .disabled)
//		photoDeniedView.backgroundColor = UIColor.cFFFFFF_2A3342
//		let text = NSMutableAttributedString(string: "请在iPhone的“设置-隐私-照片”选项中，\n允许爱卡汽车访问你的照片＞", attributes: [NSForegroundColorAttributeName: UIColor.c1DA1F2_208BCF, NSFontAttributeName: UIFont.small])
//		let highlight = YYTextHighlight()
//		highlight.setColor(UIColor.c138BD5_1B79B4)
//		highlight.tapAction = { (_, _, _, _) in
//			let url = URL(string: UIApplicationOpenSettingsURLString)
//			if let url = url {
//				if UIApplication.shared.canOpenURL(url) {
//					UIApplication.shared.openURL(url)
//				}
//			}
//		}
//		text.yy_setTextHighlight(highlight, range: text.yy_rangeOfAll())
//		photoDeniedLabel.attributedText = text
//
//        rightNavButton.setBackgroundImage(XCRTheme.image(named: "navClose"), for: .normal)
//        rightNavButton.setBackgroundImage(XCRTheme.image(named: "navClose_highlighted"), for: .highlighted)
//		rightNavButton.sizeToFit()
	}

}

class XCRPhotosAsset: NSObject {
    var asset: PHAsset
    var isGIF: Bool
    init(_ asset: PHAsset, isGIF: Bool = false) {
        self.asset = asset
        self.isGIF = isGIF
        super.init()
    }
}
//swiftlint:enable empty_count

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
