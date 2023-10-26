//
//  ImageBrowerCollectionViewCell.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/2/16.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class ImageBrowerCollectionViewCell: UICollectionViewCell, UIScrollViewDelegate {
    
    // MARK: - Property
    var image: UIImage? {
        didSet{
            if let image = image {
                imageView.image = image
                setNeedsLayout()
            }
        }
    }
    
    var name: String? {
        didSet {
            if let n = name {
                nameLabel.text = n
            }
        }
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.red.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.scrollsToTop = false
        scrollView.bouncesZoom = true
        scrollView.isMultipleTouchEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delaysContentTouches = false
        scrollView.canCancelContentTouches = true
        scrollView.alwaysBounceVertical = false
        scrollView.backgroundColor = UIColor.black
        return scrollView
    }()
    
    /// 图片
    fileprivate(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    // MARK: - LifeCyle
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        scrollView.addSubview(imageView)
        hand()
        
        contentView.addSubview(nameLabel)
        nameLabel.frame = CGRect(x: 0, y: CGRectGetHeight(self.contentView.bounds) - 100, width: CGRectGetWidth(self.contentView.bounds), height: 50)
        
        NotificationCenter.default.reactive.notifications(forName: UIDevice.orientationDidChangeNotification).observe { [weak self](_) in
            // self?.resizeSubviews()
            self?.setNeedsLayout()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let image = imageView.image {
            let viewSize = contentView.bounds.size
            let imageSize = image.size
            var imageViewBounds = CGRect.zero
//            let boundsSize = self.bounds.size
//            let boundsAR = boundsSize.width / boundsSize.height
//            let imageAR = imageSize.width / imageSize.height
//            if imageAR > boundsAR {
//                if imageSize.width < boundsSize.width {
//                    imageViewBounds.size.height = boundsSize.width / imageSize.width * imageSize.height
//                    imageViewBounds.size.width = boundsSize.width
//                } else {
//                    imageViewBounds.size.width = boundsSize.height / imageSize.height * imageSize.width
//                    imageViewBounds.size.height = boundsSize.height
//                }
//            } else {
//                if imageSize.height < boundsSize.height {
//                    imageViewBounds.size.width = boundsSize.height / imageSize.height * imageSize.width
//                    imageViewBounds.size.height = boundsSize.height
//                } else {
//                    imageViewBounds.size.height = boundsSize.width / imageSize.width * imageSize.height
//                    imageViewBounds.size.width = boundsSize.width
//                }
//            }
            if viewSize.width > viewSize.height {
                imageViewBounds.size.height = viewSize.height
                imageViewBounds.size.width = imageViewBounds.size.height / imageSize.height * imageSize.width
            } else {
                imageViewBounds.size.width = viewSize.width
                imageViewBounds.size.height = imageSize.height / imageSize.width * imageViewBounds.size.width
            }
            imageView.bounds = imageViewBounds
            imageView.center = contentView.center
            scrollView.zoomScale = 1
            scrollView.contentSize = contentView.frame.size
            scrollView.scrollRectToVisible(self.bounds, animated: false)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        scrollView.contentSize = contentView.frame.size
        scrollView.zoomScale = 1
    }
    
    // MARK: - UIScrollViewDelegate
    // 代理方法 返回一个放大缩小的视图
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView;
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // centerImageView()
        let x: CGFloat = (scrollView.frame.size.width > scrollView.contentSize.width) ? (scrollView.frame.size.width - scrollView.contentSize.width) * 0.5: 0.0
        let y: CGFloat = (scrollView.frame.size.height > scrollView.contentSize.height) ? (scrollView.frame.size.height - scrollView.contentSize.height) * 0.5: 0.0
        imageView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + x, y: scrollView.contentSize.height * 0.5 + y)
    }
    
    fileprivate func hand() {
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(ImageBrowerCollectionViewCell.tapAction(_:)))
        tapGes.numberOfTapsRequired = 1 // 设置点击次数
        tapGes.numberOfTouchesRequired = 1 // 设置触摸点
        imageView.addGestureRecognizer(tapGes)
        
        let tapGes1 = UITapGestureRecognizer(target: self, action: #selector(ImageBrowerCollectionViewCell.tapAction(_:)))
        tapGes1.numberOfTapsRequired = 2 // 设置点击次数
        tapGes1.numberOfTouchesRequired = 1 // 设置触摸点
        imageView.addGestureRecognizer(tapGes1)
        tapGes.require(toFail: tapGes1)

    }
    
    @objc fileprivate func tapAction(_ tap: UITapGestureRecognizer) {
        switch tap.numberOfTapsRequired {
        case 1:
            // 点击一次隐藏navBar
            break
        case 2:
            if scrollView.zoomScale > scrollView.minimumZoomScale {
                scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            } else {
                let touchPoint = tap.location(in: imageView)
                let newZoomScall = scrollView.maximumZoomScale
                let xsize = frame.width / newZoomScall
                let ysize = frame.height / newZoomScall
                scrollView.zoom(to: CGRect(x: touchPoint.x - xsize / 2, y: touchPoint.y - ysize / 2, width: xsize, height: ysize), animated: true)
            }
        default:
            break;
        }
    }
    
}
