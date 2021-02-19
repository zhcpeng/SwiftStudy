//
//  AppDelegate.swift
//  SwiftStudy
//
//  Created by zhangchunpeng1 on 2021/2/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        // Override point for customization after application launch.
//        self.window!.backgroundColor = UIColor.white
//        
////        let vc = ViewController.init(nibName: "ViewController", bundle:nil)
//        let vc = ViewController()
//        self.navigationController = UINavigationController(rootViewController : vc)
//        self.window?.rootViewController = self.navigationController
//        
//        
//        // register local notification
//        application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
//        
////        DispatchQueue.global().async {
////            let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.test), userInfo: nil, repeats: true)
////
////            RunLoop.current.add(timer, forMode: .common)
////            print("curr: \(RunLoop.current)")
////            var keep = true
////            DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
////                keep = false
////            }
////            while(keep && RunLoop.current.run(mode: .default, before: Date.init(timeIntervalSinceNow: 1))) {
////
////            }
////            RunLoop.current.run()
////            print("111-\(Thread.current)")
////        }
//        
//        self.window!.makeKeyAndVisible()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

