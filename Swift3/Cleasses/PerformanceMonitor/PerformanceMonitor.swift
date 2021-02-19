//
//  PerformanceMonitorSwift.swift
//  Swift4
//
//  Created by ZhangChunPeng on 2018/7/25.
//  Copyright © 2018年 zhcpeng. All rights reserved.
//

import UIKit

class PerformanceMonitorSwift: NSObject {

    static let share: PerformanceMonitorSwift = PerformanceMonitorSwift()

    private var timeoutCount: ushort = 0
    private var observer: CFRunLoopObserver?
    private var activity: CFRunLoopActivity?
    private var semaphore: DispatchSemaphore?

    static let runloopCallBack: CFRunLoopObserverCallBack = { (observer, activity, context) -> () in
        let monitor = unsafeBitCast(context, to: PerformanceMonitorSwift.self)
        monitor.activity = activity
        _ = monitor.semaphore?.signal()
    }

    public func start() {
        guard observer == nil else { return }

        semaphore = DispatchSemaphore(value: 0)

        var context = CFRunLoopObserverContext(version: 0, info: unsafeBitCast(self, to: UnsafeMutablePointer.self), retain: nil, release: nil, copyDescription: nil)
        if let observer = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, /*0xffffff*/0, PerformanceMonitorSwift.runloopCallBack, &context) {
            self.observer = observer
            CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .commonModes)
        }

        DispatchQueue.global().async {
            while (true) {
                guard let semaphore = self.semaphore else {
                    return
                }
                let st = semaphore.wait(timeout: .now() + 0.05)
                if st == .timedOut {

                    if let activity = self.activity, (activity == .beforeSources || activity == .afterWaiting) {
                        self.timeoutCount += 1
                        if self.timeoutCount < 5 {
                            continue
                        }
                        let log = BSBacktraceLogger.bs_backtraceOfMainThread()
                        print(log!)
                        print("卡卡卡卡卡卡卡！！！！！！！！")
                    }
                }
                self.timeoutCount = 0
            }
        }
    }

    public func stop() {
        timeoutCount = 0
        if let _ = observer {
            CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer!, .commonModes)
        }
        observer = nil
        activity = nil
        semaphore = nil
    }
}
