//
//  ImageLibraryCollectionViewCell.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/6/15.
//

import UIKit

class ImageLibraryCollectionViewCell: UICollectionViewCell {
    
    var image: UIImage? {
        didSet{
            if let image = image {
                imageView.image = image
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.contentView.addSubview(imageView)
        imageView.frame = self.contentView.bounds;
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
