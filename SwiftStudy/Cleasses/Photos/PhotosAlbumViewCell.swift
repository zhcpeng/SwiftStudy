//
//  PhotosAlbumViewCell.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2017/12/20.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit
import Photos

class PhotosAlbumViewCell: UICollectionViewCell {
    /// 父控制器
    weak var controller: PhotosAlbumViewController?
    /// 照片唯一标识符
    var representedAssetIdentifier = "" /*{
        didSet {
            if !representedAssetIdentifier.isEmpty {
                for model in controller!.selectedPhotos where model.representedAssetIdentifier == representedAssetIdentifier {
                    setSelected(true, animate: false)
                    print("\(#file):\(#function):\(#line): \(representedAssetIdentifier)")
                    break
                }
            }
        }
    }*/

    /// 是否选中
    private var select = false

    /// 照片资源路径
    var phAsset: PHAsset?

    /// 照片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private var selectedMaskView: UIView = UIView()
    private var countLabel: UILabel = UILabel()

    func selected(_ selected: Bool, animate: Bool = true, index: Int = -1) {
        selectedMaskView.isHidden = !selected
        countLabel.text = index >= 0 ? "\(index + 1)" : ""
    }


    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        clipsToBounds = true
        initUI()
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        select = false
        representedAssetIdentifier = ""
        countLabel.text = ""
        selectedMaskView.isHidden = true
    }

    /// 设置是否选中并且设置按钮选中动画
    func setSelected(_ selected: Bool, animate: Bool) {
        self.select = selected
//        changeButton(selected, animate: animate)
        selectedMaskView.isHidden = !selected
        if selected {
            var contentPhoto = false
            for (index, model) in controller!.selectedPhotos.enumerated() where model.representedAssetIdentifier == representedAssetIdentifier {
                countLabel.text = "\(index + 1)"
                contentPhoto = true
                break
            }
            if contentPhoto == false {
                let model = XCRPhotosSelectedModel()
                model.representedAssetIdentifier = representedAssetIdentifier
                model.image = imageView.image
                model.phAsset = phAsset
                controller!.selectedPhotos.append(model)
                countLabel.text = "\(controller!.selectedPhotos.count)"

                print("\(#file):\(#function): \(controller!.selectedPhotos.count)")
            }
        } else {
            countLabel.text = ""
            for (index, model) in controller!.selectedPhotos.enumerated() where model.representedAssetIdentifier == self.representedAssetIdentifier {
                DispatchQueue.main.async {
                    self.controller!.selectedPhotos.remove(at: index)
                }
                break
            }
        }
    }

    private func initUI() {
        selectedMaskView.isHidden = true
        selectedMaskView.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        countLabel.font = UIFont.systemFont(ofSize: 32)
        countLabel.textAlignment = .center
        countLabel.textColor = UIColor.white
        countLabel.isUserInteractionEnabled = false
    }

    private func commonInit() {
        contentView.addSubview(imageView)
        contentView.addSubview(selectedMaskView)
        contentView.addSubview(countLabel)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        selectedMaskView.snp.makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
        countLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
