//
//  XCRPhotosTakePicturesCell.swift
//  XCar
//
//  Created by ZhangChunpeng on 16/8/29.
//  Copyright © 2016年 塞纳德（北京）信息技术有限公司. All rights reserved.
//

import UIKit

/// 拍照 cell
class XCRPhotosTakePicturesCell: UICollectionViewCell {
	// MARK: - Property
	private var imageView: UIImageView!

	// MARK: - LifeCycle
	override init(frame: CGRect) {
		super.init(frame: frame)

        imageView = UIImageView()
        imageView.contentMode = .center
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
            make.center.equalToSuperview()
        }
//		changeTheme()
//        NotificationCenter.default.reactive.notifications(forName: Notification.Name.XCRThemeChanged).observe { [weak self] _ in
//            self?.changeTheme()
//        }
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

//    // MARK: - Theme
//    private func changeTheme() {
//        contentView.backgroundColor = UIColor.cF6F8F9_242B38
//        imageView.image = XCRTheme.image(named: "photo_album_takephoto")
//    }
}
