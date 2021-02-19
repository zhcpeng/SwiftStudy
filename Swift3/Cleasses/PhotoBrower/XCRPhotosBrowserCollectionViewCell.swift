//
//  XCRPhotosBrowserViewCell.swift
//  XCar
//
//  Created by ZhangChunpeng on 16/9/7.
//  Copyright © 2016年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

import Kingfisher

/// 图片浏览cell
class XCRPhotosBrowserCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
	// MARK: - Property
	/// 图片url
	var url: String = "" {
		didSet {
			self.setImageWithURLString(url)
		}
	}

	/// 加载中
	fileprivate lazy var loadingView: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)

	/// 图片容器
	fileprivate lazy var scrollView: UIScrollView = {
		let scrollView = UIScrollView()
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.delegate = self
		scrollView.bouncesZoom = true
		scrollView.minimumZoomScale = 1
		scrollView.maximumZoomScale = 2.5
		scrollView.isMultipleTouchEnabled = true
		scrollView.scrollsToTop = false
		scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		scrollView.delaysContentTouches = false
		scrollView.canCancelContentTouches = true
		scrollView.alwaysBounceVertical = false

		return scrollView
	}()

	/// 图片view
	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.isUserInteractionEnabled = true
		return imageView
	}()

//	/// 加载失败
//	private lazy var emptyView: XCREmptyView = {
//		let emptyView = XCREmptyView()
//		emptyView.type = .NoNet
//		emptyView.hidden = true
//		emptyView.block = { [weak self] in
//			self?.setImageWithURLString(self?.url)
//		}
//		return emptyView
//	}()

	/// 图片单击手势block
	var singleTagGestureBlock: (() -> ())?

	/// 图片下载成功block
	var imageDownloadCompletionHandler: ((_ success: Bool) -> ())?

	/// 图片是否下载成功
	var imageDownloadSuccess = false

	// MARK: - LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)

		self.backgroundColor = UIColor.black
		self.commonInit()
		self.addGestureRecognizers()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()

		scrollView.zoomScale = 1
		imageDownloadSuccess = false
	}

	// MAEK: - UIScrollViewDelegate
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		let x: CGFloat = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5: 0.0
		let y: CGFloat = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5: 0.0
		imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + x, y: scrollView.contentSize.height * 0.5 + y)
	}

	// MARK: - Private Method
	fileprivate func commonInit() {
		self.contentView.addSubview(scrollView)
		self.contentView.addSubview(loadingView)
//		self.contentView.addSubview(emptyView)
		scrollView.snp.makeConstraints { (make) in
			make.edges.equalTo(self.contentView)
		}
//		emptyView.snp.makeConstraints { (make) in
//			make.edges.equalTo(self.contentView)
//		}
		loadingView.snp.makeConstraints { (make) in
			make.center.equalTo(self.contentView)
		}
		scrollView.addSubview(imageView)
		imageView.frame = self.bounds
	}

	fileprivate func setImageWithURLString(_ url: String?) {
		guard let url = url, url.isEmpty == false else {
			return
		}
		self.loadingView.startAnimating()
//		self.emptyView.hidden = true
//        self.imageView.kf_setImage(URL(string: url)) { (image, error, cacheType, imageURL)
        
//        self.imageView.kf.setImage(with: URL(string: url), placeholder: nil, options: nil) { (result) in
//            switch result {
//            case .success(let image):
//                <#code#>
//            default:
//                <#code#>
//            }
//        }
        
        
		self.imageView.kf.setImage(with: URL(string: url)) { (image, error, cacheType, imageURL) in
			self.loadingView.stopAnimating()
			self.imageDownloadCompletionHandler?((error == nil))
			self.imageDownloadSuccess = (error == nil)
			if error != nil {
//				self.emptyView.hidden = false
				return
			}
			if let image = image {
				var frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0)
				let size = image.size
				if size.height / size.width > self.frame.size.height / self.frame.size.width {
					frame.size.height = floor(size.height / (size.width / self.frame.size.width))
					self.imageView.frame = frame
				} else {
					var height = size.height / size.width * self.frame.size.width
					if height < 1 /*|| Double.nan(height)*/ {
						height = self.frame.size.height
					}
					frame.size.height = floor(height)
					self.imageView.frame = frame
					self.imageView.center = CGPoint(x: self.contentView.center.x, y: self.frame.size.height / 2)
				}
				if frame.size.height > self.frame.size.height && frame.size.height - self.frame.size.height <= 1 {
					frame.size.height = self.frame.size.height
					self.imageView.frame = frame
				}

				self.scrollView.contentSize = CGSize(width: self.frame.size.width, height: max(frame.size.height, self.frame.size.height))
				self.scrollView.scrollRectToVisible(self.bounds, animated: false)
				self.scrollView.alwaysBounceVertical = frame.size.height > self.frame.size.height
			}
		}
	}

	fileprivate func addGestureRecognizers() {
		// 单击
		let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageSingleTapAction(_:)))
		singleTap.numberOfTapsRequired = 1
		imageView.addGestureRecognizer(singleTap)

		// 双击
		let doubleTap = UITapGestureRecognizer(target: self, action: #selector(imageDoubleTapAction(_:)))
		doubleTap.numberOfTapsRequired = 2
		imageView.addGestureRecognizer(doubleTap)

		singleTap.require(toFail: doubleTap)
	}

	@objc fileprivate func imageSingleTapAction(_ gest: UIGestureRecognizer) {
		self.singleTagGestureBlock?()
	}
	@objc fileprivate func imageDoubleTapAction(_ gest: UIGestureRecognizer) {
		if scrollView.zoomScale > 1.0 {
			scrollView.setZoomScale(1.0, animated: true)
		} else {
			let touchPoint = gest.location(in: imageView)
			let x = self.frame.size.width / scrollView.maximumZoomScale
			let y = self.frame.size.height / scrollView.maximumZoomScale
			scrollView.zoom(to: CGRect.init(x: touchPoint.x - x / 2, y: touchPoint.y - y / 2, width: x, height: y), animated: true)
		}
	}

}
