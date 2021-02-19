//
//  ImageManager.swift
//  Swift4
//
//  Created by zhcpeng on 2020/12/23.
//  Copyright © 2020 zhcpeng. All rights reserved.
//

import UIKit

//import Kingfisher

class ImageManager: NSObject {
    static let shared: ImageManager = ImageManager()
    
    private let fileManager = FileManager.default
    private let paths = NSHomeDirectory() + "/Documents/image"
    private lazy var dateFotmatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd_HH-mm-ss"
        return formatter
    }()
    
    private override init() {
        if !FileManager.default.fileExists(atPath: paths) {
            try? FileManager.default.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    
    func saveImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            let path = paths + "/" + dateFotmatter.string(from: Date()) + ".jpg"
            try? data.write(to: URL(fileURLWithPath: path), options: [])
        } else if let data = image.pngData() {
            let path = paths + "/" + dateFotmatter.string(from: Date()) + ".png"
            try? data.write(to: URL(fileURLWithPath: path), options: [])
        }
        
    }
    

}
