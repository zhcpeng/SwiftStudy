//
//  GIFViewController.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/7/12.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit
import Kingfisher
import Photos
import MobileCoreServices
//import ALAssetsLibrary

class GIFViewController: UIViewController, XCRPhotosAlbumDelegate {

    private lazy var imageView: UIImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.


        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { 
            let photosAlbumViewController = XCRPhotosAlbumViewController()
//            photosAlbumViewController.selectedPhotosLimit = maxImageCount - imageModels.count
            photosAlbumViewController.delegate = self
//            photosAlbumViewController.showTakePhoto = false
            self.present(UINavigationController(rootViewController: photosAlbumViewController), animated: true, completion: nil)

        }

        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - XCRPhotosAlbumDelegate
    // 相册选择界面 - 完成选择
    func photosAlbum(_ photosAlbum: XCRPhotosAlbumViewController, didFinish photos: [XCRPhotosSelectedModel]){

        guard let model = photos.first else {
            return
        }

        let options = PHImageRequestOptions()
        options.resizeMode = .fast
        options.isSynchronous = true

        PHImageManager.default().requestImageData(for: model.phAsset!, options: options, resultHandler: { (data, dataUTI, _, _) in
            if let uti = dataUTI, uti == (kUTTypeGIF as String) {
                // 是git图
//                isGIF = true

                let image = UIImage.sd_animatedGIF(with: data!)
                self.imageView.image = image



            }
        })

    }

}
