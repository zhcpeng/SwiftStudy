//
//  PhotosBrowerCollectionViewCell.swift
//  Swift3
//
//  Created by ZhangChunpeng on 2017/9/5.
//  Copyright © 2017年 zhcpeng. All rights reserved.
//

import UIKit

class PhotosBrowerCollectionViewCell: UICollectionViewCell {

    private(set) var imageView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
