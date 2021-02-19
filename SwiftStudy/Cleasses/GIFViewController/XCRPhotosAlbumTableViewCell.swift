//
//  XCRPhotosAlbumTableViewCell.swift
//  XCar
//
//  Created by ZhangChunpeng on 16/8/29.
//  Copyright © 2016年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

/// 相册列表cell
class XCRPhotosAlbumTableViewCell: UITableViewCell {
	// MARK: - Property
	/// 照片唯一标识符
	var representedAssetIdentifier = ""

	/// 相册图片（默认为相册第一张图片，没有则为占位图）
	var albumImage: UIImage? = nil {
		didSet {
			albumImageView.image = albumImage
		}
	}

	fileprivate lazy var albumImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		return imageView
	}()

	/// 相册名称
	lazy var albumTitleLabel: UILabel = {
		let label = UILabel()
//		label.font = UIFont.normal
		return label
	}()

	/// 相册照片数量
	lazy var albumCountLabel: UILabel = {
		let label = UILabel()
//		label.font = UIFont.small
		return label
	}()

	// MARK: - LifeCycle
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		self.backgroundColor = UIColor.clear
		self.selectedBackgroundView = UIView()
		self.commonInit()
//		self.theme()
//		NotificationCenter.default.reactive.notifications(forName: Notification.Name.XCRThemeChanged).observe { [weak self] _ in
//			self?.theme()
//		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	// MARK: - Private Method
	fileprivate func commonInit() {
		self.contentView.addSubview(albumImageView)
		self.contentView.addSubview(albumTitleLabel)
		self.contentView.addSubview(albumCountLabel)
		albumImageView.snp.makeConstraints { (make) in
			make.top.left.bottom.equalTo(self.contentView).inset(UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 0))
			make.size.equalTo(CGSize(width: 60, height: 60))
		}
		albumTitleLabel.snp.makeConstraints { (make) in
			make.left.equalTo(albumImageView.snp.right).offset(15)
			make.centerY.equalTo(albumImageView)
		}
		albumCountLabel.snp.makeConstraints { (make) in
			make.left.equalTo(albumTitleLabel.snp.right).offset(15)
			make.centerY.equalTo(albumImageView)
		}
	}

	// MARK: - Theme
	fileprivate func theme() {
//		self.selectedBackgroundView?.backgroundColor = UIColor.cF6F8F9_242B38
//		albumTitleLabel.textColor = UIColor.c44494D_8A99A3
//		albumCountLabel.textColor = UIColor.cB5B8BB_596672
//		if albumImage == nil {
//			albumImageView.image = XCRTheme.placeholderImage
//		}
	}
}
