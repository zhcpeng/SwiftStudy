//
//  AppDelegate.swift
//  Swift3
//
//  Created by zhcpeng on 16/5/27.
//  Copyright © 2016年 zhcpeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController : UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.white
        
//        let vc = ViewController.init(nibName: "ViewController", bundle:nil)
        let vc = ViewController()
        self.navigationController = UINavigationController(rootViewController : vc)
        self.window?.rootViewController = self.navigationController
        
        
        // register local notification
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
        
//        DispatchQueue.global().async {
//            let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.test), userInfo: nil, repeats: true)
//
//            RunLoop.current.add(timer, forMode: .common)
//            print("curr: \(RunLoop.current)")
//            var keep = true
//            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
//                keep = false
//            }
//            while(keep && RunLoop.current.run(mode: .default, before: Date.init(timeIntervalSinceNow: 1))) {
//
//            }
//            RunLoop.current.run()
//            print("111-\(Thread.current)")
//        }
        
        self.window!.makeKeyAndVisible()
        return true
    }
    
//    @objc func test() {
//        print("222-\(Thread.current)")
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
//    var backgroundSessionCompletionHandler: (() -> Void)?
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
//        self.backgroundSessionCompletionHandler = completionHandler
        DownloadManager.shared.manager.backgroundCompletionHandler = completionHandler
    }
}

