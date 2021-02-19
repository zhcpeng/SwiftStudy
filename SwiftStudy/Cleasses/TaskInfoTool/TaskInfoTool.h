//
//  TaskInfoTool.h
//  XCar6
//
//  Created by zhcpeng on 16/5/24.
//  Copyright © 2016年 爱卡汽车. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  开发工具箱
 */
@interface TaskInfoTool : NSObject

/**
 *  工具箱单例
 *
 *  @return 工具箱单例实例
 */
+ (instancetype)shareTaskInfoTool;

/**
 *  显示FPS
 */
- (void)showFPS;

/**
 *  CPU使用率
 */
- (void)showCPU;

/**
 *  显示内存使用量
 */
- (void)showMemory;

@end
