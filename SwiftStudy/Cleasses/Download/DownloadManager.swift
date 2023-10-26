//
//  DownloadManager.swift
//  Swift4
//
//  Created by zhcpeng on 2019/7/19.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import UIKit
import Alamofire
//import MBProgressHUD

class DownloadManager: NSObject {
    static let shared: DownloadManager = DownloadManager()
    var isDownload: Bool = false
    private var downloadList: [String] = []
    private var downloadRequest: DownloadRequest?
    var downloadProgress: ((Progress)->Void)?
    var backgroundDownloadFinish: (() -> Void)?
    private(set) var manager: SessionManager = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.zhcpeng.Swift4.background-session")
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.allowsCellularAccess = false
        return SessionManager(configuration: configuration)
    }()
    
    private let destination: DownloadRequest.DownloadFileDestination = { _, response in
        let fileURL = ZFileManager.shared.rootURL.appendingPathComponent(response.suggestedFilename!)
        
//        let fileURL = DownloadManager.createFileName(response.suggestedFilename!)
        return (fileURL, [.removePreviousFile,.createIntermediateDirectories])
    }
    
    // URLSession
//    var currentProgress: ((Int64, Int64)->Void)?
//    private var currentDownloadTask: URLSessionDownloadTask?
//    lazy var session: URLSession = {
//        let configuration = URLSessionConfiguration.background(withIdentifier: "com.zhcpeng.Swift4.download")
//        let session = URLSession.init(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
//        return session
//    }()
    
    func addDownloadURL(_ url: String) {
        let url = url.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        if !url.isEmpty && (url.hasSuffix("mp4") || url.hasSuffix("MP4")) {
            downloadList.append(url)
            download()
//        }
    }
    
    private func download() {
        if isDownload || downloadList.isEmpty {
            return
        }
        guard let url = downloadList.first, let URL = URL.init(string: url) else { return }
        isDownload = true
        
        downloadRequest = manager.download(URL, to: destination).responseData(completionHandler: downloadResponse).downloadProgress { [weak self](progress) in
            self?.downloadProgress?(progress)
        }
        
        // URLSession
//        currentDownloadTask?.cancel()
//        currentDownloadTask = session.downloadTask(with: URL)
//        currentDownloadTask!.resume()
    }
    
    func cancelDownload() {
        isDownload = false
        downloadRequest?.cancel()
    }
    
    private func downloadResponse(response:DownloadResponse<Data>){
        switch response.result {
        case .success(_):
            // 下载完成
            DispatchQueue.main.async {
                self.isDownload = false
                if !self.downloadList.isEmpty {
                    self.downloadList.remove(at: 0)
                }
                self.downloadRequest?.cancel()
                self.downloadRequest = nil
                self.download()
                
                ZFileManager.shared.loadFile()
                
                self.backgroundDownloadFinish?()
            }
        case .failure(error:):
            isDownload = false
            download()
            print("下载失败！！！")
            break
        }
    }
    
    private class func createFileName(_ name: String) -> URL {
        let fileURL = ZFileManager.shared.rootURL.appendingPathComponent(name)
        if FileManager.default.fileExists(atPath: ZFileManager.shared.rootPath + "." + name) {
//            var newName = name
            let list = name.split(separator: ".")
            if var firstName = list.first {
                let dateForttet = DateFormatter()
                dateForttet.dateFormat = "MMddHHmmss"
                let last = dateForttet.string(from: Date.now)
                firstName = firstName + (firstName.contains("_") ? "_" : "") + last
                return self.createFileName(firstName + "." + (list.last ?? "mp4"))
            } else {
                return fileURL
            }
        } else {
            return fileURL
        }
        
    }
}

// URLSession
//extension DownloadManager: URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        print("下载完成 - \(location)")
//
//        let name = downloadTask.response?.suggestedFilename ?? Date().description
//        let fileURL = ZFileManager.shared.rootURL.appendingPathComponent(name)
//        do {
//            try FileManager.default.moveItem(at: location, to: fileURL)
//        } catch let error as NSError {
//            print("移动文件失败:\(error)")
//        }
//
//        self.isDownload = false
//        // 下载完成
//        DispatchQueue.main.async {
//            if !self.downloadList.isEmpty {
//                self.downloadList.remove(at: 0)
//            }
//            self.download()
//            ZFileManager.shared.loadFile()
//        }
//    }
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        currentProgress?(totalBytesWritten, totalBytesExpectedToWrite)
//    }
//
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        isDownload = false
//        if let e = error {
//            print(e)
//        }
//    }
//
//    // 下载后台完成
//    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
//        print("后台任务")
//        DispatchQueue.main.async {
//            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let backgroundHandle = appDelegate.backgroundSessionCompletionHandler else { return }
//            backgroundHandle()
//        }
//    }
//
//}
