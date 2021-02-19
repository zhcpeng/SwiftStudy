//
//  XCRPhotosAlbumViewCell.swift
//  XCar
//
//  Created by ZhangChunpeng on 16/8/29.
//  Copyright © 2016年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

import Photos

/// 相册 照片 列表 cell
class XCRPhotosAlbumViewCell: UICollectionViewCell {
	// MARK: - Property
	/// 父控制器
	weak var controller: XCRPhotosAlbumViewController?

	/// 照片唯一标识符
	var representedAssetIdentifier = "" {
		didSet {
			if !representedAssetIdentifier.isEmpty {
				for model in controller!.selectedPhotos where model.representedAssetIdentifier == representedAssetIdentifier {
					setSelected(true, animate: false)
                    break
				}
			}
		}
	}

    var isGIF: Bool = false {
        didSet {
            tagButton.isHidden = !isGIF
        }
    }

	/// 照片资源路径
	var phAsset: PHAsset?

	/// 照片
	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		return imageView
	}()

	private(set) lazy var selectedButton: UIButton = {
		let button = UIButton(type: .custom)
		button.isExclusiveTouch = true
//		button.touchExtendInset = UIEdgeInsets(top: -4, left: -15, bottom: -15, right: -4)
//		button.titleLabel?.font = UIFont.small
		button.titleLabel?.adjustsFontSizeToFitWidth = true
		button.titleLabel?.snp.makeConstraints({ (make) in
			make.center.equalTo(button)
		})
		button.reactive.controlEvents(.touchUpInside).observeValues({ [weak self](_) in
			guard let strongSelf = self else { return }
//            if !strongSelf.select {
//                // 判断图片最小宽度
//                if strongSelf.select == false, let asset = strongSelf.phAsset, let minWidth = strongSelf.controller?.minImageWidth, minWidth > 0, asset.pixelWidth < minWidth {
//                    XCRAlertBanner(style: .failure, position: .top, title: "图片宽度不能小于\(minWidth)像素").show()
//                    return
//                }
//                if strongSelf.select == false && strongSelf.controller!.selectedPhotos.count >= strongSelf.controller!.selectedPhotosLimit {
//                    XCRAlertBanner(style: .failure, position: .top, title: "最多只能添加\(strongSelf.controller!.selectedPhotosLimit)张照片哦").show()
//                    return
//                }
//            }
            strongSelf.setSelected(!(strongSelf.select), animate: true)
		})

		return button
	}()

	/// 是否选中
	fileprivate var select = false

	/// 设置是否选中并且设置按钮选中动画
	fileprivate func setSelected(_ selected: Bool, animate: Bool) {
		self.select = selected
        changeButton(selected, animate: animate)
		if selected {
			var contentPhoto = false
			for (index, model) in controller!.selectedPhotos.enumerated() where model.representedAssetIdentifier == representedAssetIdentifier {
				selectedButton.setTitle(String(index + 1), for: .normal)
				contentPhoto = true
				break
			}
			if contentPhoto == false {
				let model = XCRPhotosSelectedModel()
				model.representedAssetIdentifier = representedAssetIdentifier
				model.image = imageView.image
				model.phAsset = phAsset
				controller!.selectedPhotos.append(model)
				selectedButton.setTitle(String(controller!.selectedPhotos.count), for: .normal)
			}
		} else {
			selectedButton.setTitle("", for: .normal)
			for (index, model) in controller!.selectedPhotos.enumerated() where model.representedAssetIdentifier == self.representedAssetIdentifier {
                DispatchQueue.main.async {
                    self.controller!.selectedPhotos.remove(at: index)
                }
                break
			}
		}
	}

    private var tagButton: UIButton!

	// MARK: - LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)

        initUI()
		self.clipsToBounds = true
		self.commonInit()
		self.theme()
//		NotificationCenter.default.reactive.notifications(forName: Notification.Name.XCRThemeChanged).observe { [weak self] _ in
//			self?.theme()
//		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		select = false
		representedAssetIdentifier = ""
		selectedButton.setTitle("", for: .normal)
		changeButton(false, animate: false)
        isGIF = false
	}

	// MARK: - Private Method
    private func initUI() {
        tagButton = UIButton(type: .custom)
        tagButton.setTitle("动图", for: .normal)
//        tagButton.titleLabel?.font = UIFont.mini
//        tagButton.setBackgroundColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
        tagButton.isHidden = true
        tagButton.isUserInteractionEnabled = false
    }

	fileprivate func commonInit() {
		contentView.addSubview(imageView)
		contentView.addSubview(selectedButton)
		imageView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		selectedButton.snp.makeConstraints { (make) in
			make.top.right.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 4))
			make.size.equalTo(CGSize(width: 22, height: 22))
		}
        contentView.addSubview(tagButton)
        tagButton.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(18)
            make.width.equalTo(30)
        }
	}

	fileprivate func changeButton(_ selected: Bool, animate: Bool = false) {
		var normalImageName = ""
		var highlightedImageName = ""
		if selected {
			normalImageName = "discover_photos_cell_yes"
			highlightedImageName = "discover_photos_cell_yes_h"
			if animate {
				UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: {
					self.selectedButton.layer.setValue(0.8, forKeyPath: "transform.scale")
				}) { (_) in
					UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: {
						self.selectedButton.layer.setValue(1.1, forKeyPath: "transform.scale")
					}) { (_) in
						UIView.animate(withDuration: 0.15, delay: 0, options: .beginFromCurrentState, animations: {
							self.selectedButton.layer.setValue(1.0, forKeyPath: "transform.scale")
							}, completion: nil)
					}
				}
			}
		} else {
			normalImageName = "discover_photos_cell_no"
			highlightedImageName = "discover_photos_cell_no_h"
		}
//		selectedButton.setBackgroundImage(XCRTheme.image(named: normalImageName), for: .normal)
//		selectedButton.setBackgroundImage(XCRTheme.image(named: highlightedImageName), for: .highlighted)
	}

	// MARK: - Theme
	fileprivate func theme() {
//		selectedButton.setTitleColor(UIColor.cFFFFFF_D6DCE6, for: .normal)
//		changeButton(select, animate: false)
	}
}
