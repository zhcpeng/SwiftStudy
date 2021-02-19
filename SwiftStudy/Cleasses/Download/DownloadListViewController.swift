//
//  DownloadListViewController.swift
//  Swift4
//
//  Created by zhcpeng on 2019/7/19.
//  Copyright © 2019 zhcpeng. All rights reserved.
//

import UIKit
import MBProgressHUD
import UserNotifications

class DownloadListViewController: UIViewController {
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.text = " "
        return textView
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.blue
        return button
    }()
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear", for: .normal)
        button.titleLabel!.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor.cyan
        return button
    }()
    private let progress: UIProgressView = {
        let progress = UIProgressView()
        
        return progress
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.red
        label.textAlignment = .right
        label.text = "0KB"
        return label
    }()
    
    private var timer: DispatchSourceTimer?
    private var proData: Int64 = 0
    private var currentData: Int64 = 0
    
    private var documentController: UIDocumentInteractionController?
    

    // MARK: - Life Cycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let text = UIPasteboard.general.string {
            if text.hasSuffix("mp4") || text.hasSuffix("MP4") {
                textView.text = text
            }
            UIPasteboard.general.string = ""
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.automaticallyAdjustsScrollViewInsets = false
        commonUI()
        
        ZFileManager.shared.updateFileSuccess = { [weak self]() in
            self?.tableView.reloadData()
        }
        ZFileManager.shared.loadFile()
        
        DownloadManager.shared.downloadProgress = { [weak self](pro) in
            let x = Double(integerLiteral: pro.completedUnitCount) /  Double(integerLiteral: pro.totalUnitCount)
            self?.progress.progress = Float(x)
            self?.currentData = pro.completedUnitCount
            if pro.isFinished {
                self?.progress.progress = 0
                self?.timer?.cancel()
                self?.speedLabel.text = "0KB"
//                self?.sendLocalNotification("Download Success!")
            }
        }
        DownloadManager.shared.backgroundDownloadFinish = { [weak self]() in
            self?.progress.progress = 0
            self?.timer?.cancel()
            self?.speedLabel.text = "0KB"
//            self?.sendLocalNotification("Download Success!")
        }
    }
    
    private func updateDownloadSpeed() {
        timer?.cancel()
        timer = DispatchSource.makeTimerSource()
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .nanoseconds(0))
        timer?.setEventHandler { [weak self]() in
            guard let weakSelf = self else { return }
            
            if weakSelf.currentData != 0 {
                let x = weakSelf.formatterSpeed(weakSelf.currentData - weakSelf.proData)
                print(x)
                DispatchQueue.main.async {
                    weakSelf.speedLabel.text = x
                }
                weakSelf.proData = weakSelf.currentData
            }
        }
        timer?.resume()
    }
    
    private func formatterSpeed(_ speed: Int64) -> String {
//        Double.init(integerLiteral: speed)
        switch speed {
        case 0...1014*1024:
            return "\(speed / 1024)KB"
        case (1014*1024+1)...(1014*1024*1024):
            return String(format:"%.2fMB", arguments:[Double(speed) / 1024.0 / 1024])
        case ...0:
            return "0"
        default:
            return "\(speed)"
        }
    }
    
    func sendLocalNotification(_ msg: String) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.badge = NSNumber(value: 1)
        content.title = msg
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: msg, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

        
//        UIApplication.shared.cancelAllLocalNotifications()
//        let localNotification = UILocalNotification()
//        localNotification.applicationIconBadgeNumber = 1
//        localNotification.fireDate = Date(timeIntervalSinceNow: 3)
//        localNotification.timeZone = TimeZone.current
//        localNotification.soundName = UILocalNotificationDefaultSoundName
//        localNotification.alertBody = msg
//        UIApplication.shared.scheduleLocalNotification(localNotification)
    }
    
    private func commonUI() {
        let topView = UIView()
        topView.backgroundColor = UIColor.gray
        topView.addSubviews([progress, textView, button, clearButton, speedLabel])
        self.view.addSubview(topView)
        self.view.addSubview(tableView)
        topView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
//            make.top.equalToSuperview().offset(self.view.safeAreaInsets.top)
            make.top.equalToSuperview().offset(44 + 44)
            make.height.equalTo(130)
        }
        progress.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
        }
        button.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        textView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(10)
            make.right.equalTo(button.snp.left).offset(-10)
        }
        clearButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(button)
            make.top.equalTo(button.snp.bottom).offset(5)
            make.height.equalTo(25)
        }
        speedLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(button)
            make.bottom.equalTo(textView)
//            make.top.equalTo(clearButton.snp.bottom).offset(5)
        }
        
        button.reactive.controlEvents(.touchUpInside).observeValues { [weak self](_) in
            guard let weakSelf = self else { return }
            weakSelf.view.endEditing(true)
            
            if DownloadManager.shared.isDownload {
                return
            }
            if let text = weakSelf.textView.text {
                DownloadManager.shared.addDownloadURL(text)
                weakSelf.progress.progress = 0
                weakSelf.updateDownloadSpeed()
            }
        }
        clearButton.reactive.controlEvents(.touchUpInside).observeValues { [weak self](_) in
            self?.textView.text = ""
            DownloadManager.shared.cancelDownload()
        }
    }


}

extension DownloadListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ZFileManager.shared.fileList.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = ZFileManager.shared.fileList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let url = URL.init(fileURLWithPath: ZFileManager.shared.rootPath + "/" + ZFileManager.shared.fileList[indexPath.row])
        documentController = UIDocumentInteractionController(url: url)
        documentController!.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
        
        self.textView.text = ""
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        ZFileManager.shared.deleteFile(indexPath.row)
    }
    
    
}

