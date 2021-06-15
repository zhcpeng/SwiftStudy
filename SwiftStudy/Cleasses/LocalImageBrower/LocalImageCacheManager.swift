//
//  LocalImageCacheManager.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/6/15.
//

import UIKit

class LocalImageCacheManager: NSObject {
    
    static let `default` = LocalImageCacheManager()
    
    var cache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50;
        cache.totalCostLimit = 1024 * 1024 * 100
        
        return cache
    }()

}
