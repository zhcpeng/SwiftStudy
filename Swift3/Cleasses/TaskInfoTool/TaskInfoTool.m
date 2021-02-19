//
//  TaskInfoTool.m
//  XCar6
//
//  Created by zhcpeng on 16/5/24.
//  Copyright © 2016年 爱卡汽车. All rights reserved.
//

#import "TaskInfoTool.h"

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#import <sys/sysctl.h>
#import <mach/mach.h>
#import "sys/utsname.h"

@interface TaskInfoTool (){
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    
    dispatch_source_t _cpuTimer;
    dispatch_source_t _memoryTimer;
}

@property (nonatomic, strong) UILabel *labelMemory;     ///< 内存
@property (nonatomic, strong) UILabel *labelCPU;
@property (nonatomic, strong) UILabel *labelFPS;
@property (nonatomic, assign) BOOL isShowMemory;
@property (nonatomic, assign) BOOL isShowCPU;
@property (nonatomic, assign) BOOL isShowFPS;

@end

@implementation TaskInfoTool

+ (instancetype)shareTaskInfoTool{
    static TaskInfoTool *shareTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTool  = [[TaskInfoTool alloc] init];
    });
    return shareTool;
}

- (void)dealloc{
    dispatch_source_cancel(_cpuTimer);
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)showFPS{
    _isShowFPS = YES;
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    
    [self updateFrame];
}

- (void)showCPU{
    _isShowCPU = YES;
    
    if (!_cpuTimer) {
        __weak __typeof(&*self)weakSelf = self;
        _cpuTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_cpuTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_cpuTimer, ^{
            weakSelf.labelCPU.text = [NSString stringWithFormat:@"CPU:%.1f",[self getCpuUsage]];
        });
        dispatch_resume(_cpuTimer);
    }
    
    [self updateFrame];
}

- (void)showMemory{
    _isShowMemory = YES;
    
    if (!_memoryTimer) {
        __weak __typeof(&*self)weakSelf = self;
        _memoryTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_memoryTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_memoryTimer, ^{
            weakSelf.labelMemory.text = [NSString stringWithFormat:@"%.1fM",[self getMemory]];
        });
        dispatch_resume(_memoryTimer);
    }
    
    [self updateFrame];
}

- (void)updateFrame{
    if (_isShowFPS) {
        self.labelFPS.frame = CGRectMake(10, 20, 50, 12);
    }
    
    if (_isShowFPS) {
        self.labelCPU.frame = CGRectMake(60, 20, 50, 12);
    }else{
        self.labelCPU.frame = CGRectMake(10, 20, 50, 12);
    }

    if (_isShowFPS && _isShowCPU) {
        self.labelMemory.frame = CGRectMake(110, 20, 100, 12);
    }else if (_isShowFPS || _isShowCPU){
        self.labelMemory.frame = CGRectMake(60, 20, 100, 12);
    }else{
        self.labelMemory.frame = CGRectMake(10, 20, 100, 12);
    }
}


- (UILabel *)labelCPU{
    if (!_labelCPU) {
        _labelCPU = [[UILabel alloc]init];
        _labelCPU.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        _labelCPU.userInteractionEnabled = NO;
        _labelCPU.font = [UIFont systemFontOfSize:10];
        [[UIApplication sharedApplication].keyWindow addSubview:_labelCPU];
    }
    return _labelCPU;
}

- (UILabel *)labelFPS{
    if (!_labelFPS) {
        _labelFPS = [[UILabel alloc]init];
        _labelFPS.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        _labelFPS.userInteractionEnabled = NO;
        _labelFPS.font = [UIFont systemFontOfSize:10];
        [[UIApplication sharedApplication].keyWindow addSubview:_labelFPS];
    }
    return _labelFPS;
}

- (UILabel *)labelMemory{
    if (!_labelMemory) {
        _labelMemory = [[UILabel alloc]init];
        _labelMemory.textColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
        _labelMemory.userInteractionEnabled = NO;
        _labelMemory.font = [UIFont systemFontOfSize:10];
        [[UIApplication sharedApplication].keyWindow addSubview:_labelMemory];
        [_labelMemory sizeToFit];
    }
    return _labelMemory;
}

- (float)getCpuUsage{
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    
    task_basic_info_t      basic_info;
    thread_array_t         thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t     thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0; // Mach threads
    
    basic_info = (task_basic_info_t)tinfo;
    
    // get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1;
    }
    if (thread_count > 0)
        stat_thread += thread_count;
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j < thread_count; j++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[j], THREAD_BASIC_INFO,
                         (thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
            tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
            tot_usec = tot_usec + basic_info_th->user_time.microseconds + basic_info_th->system_time.microseconds;
            tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
        }
        
    } // for each thread
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
//    NSLog(@"%f",fps);
    self.labelFPS.text = [NSString stringWithFormat:@"FPS:%.1f",fps];
}

- (double)getMemory{
    mach_task_basic_info_data_t info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kernReturnInfo = task_info (mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t) &info, &size);
    if (kernReturnInfo != KERN_SUCCESS ) {
        return NSNotFound;
    }
    return info.resident_size / 1024.0 / 1024.0;
}



@end
