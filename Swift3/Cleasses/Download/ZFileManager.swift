//
//  ZFileManager.swift
//  Swift4
//
//  Created by zhcpeng on 2019/7/19.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import UIKit

class ZFileManager: NSObject {
    
    static let shared: ZFileManager = ZFileManager()
    
    lazy var rootURL: URL = URL.init(fileURLWithPath: self.rootPath)
    
    let rootPath: String = NSHomeDirectory() + "/Documents/video"
    
    var fileList: [String] = []
    
    var updateFileSuccess: (() -> Void)?
    
    
    func loadFile() {
        if !FileManager.default.fileExists(atPath: rootPath) {
            try? FileManager.default.createDirectory(atPath: rootPath, withIntermediateDirectories: true, attributes: nil)
        }
        try? fileList = FileManager.default.contentsOfDirectory(atPath: rootPath)
        if !fileList.isEmpty {
            print("load success")
            updateFileSuccess?()
        }
        
    }
    
    func deleteFile(_ index: NSInteger) {
        if index < fileList.count {
            try? FileManager.default.removeItem(atPath: rootPath + "/" + fileList[index])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.loadFile()
            }
        }
    }
    
    

}
