//
//  YZBackgroundTaskManager.m
//  YZLocationManager
//
//  Created by 叶志强 on 2017/2/20.
//  Copyright © 2017年 CancerQ. All rights reserved.
//

#import "YZBackgroundTaskManager.h"

@interface YZBackgroundTaskManager()
@property (nonatomic, strong) NSMutableArray* bgTaskIdList;
@property (assign) UIBackgroundTaskIdentifier masterTaskId;
@end

@implementation YZBackgroundTaskManager

+(instancetype)sharedBackgroundTaskManager{
    static YZBackgroundTaskManager *sharedBGTaskManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBGTaskManager = [[YZBackgroundTaskManager alloc] init];
    });
    
    return sharedBGTaskManager;
}

-(id)init{
    self = [super init];
    if(self){
        _bgTaskIdList = [NSMutableArray array];
        _masterTaskId = UIBackgroundTaskInvalid;
    }
    
    return self;
}

-(UIBackgroundTaskIdentifier)beginNewBackgroundTask
{
    UIApplication* application = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTaskId = UIBackgroundTaskInvalid;
    if([application respondsToSelector:@selector(beginBackgroundTaskWithExpirationHandler:)]){
        bgTaskId = [application beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"后台任务 %lu 过期", (unsigned long)bgTaskId);
            
            [self.bgTaskIdList removeObject:@(bgTaskId)];
            [application endBackgroundTask:bgTaskId];
            bgTaskId = UIBackgroundTaskInvalid;
            
        }];
        if ( self.masterTaskId == UIBackgroundTaskInvalid )
        {
            self.masterTaskId = bgTaskId;
            NSLog(@"开始主任务 %lu", (unsigned long)self.masterTaskId);
        }
        else
        {
            //add this id to our list
            NSLog(@"启动后台任务 %lu", (unsigned long)bgTaskId);
            [self.bgTaskIdList addObject:@(bgTaskId)];
            [self endBackgroundTasks];
        }
    }
    
    return bgTaskId;
}

-(void)endBackgroundTasks
{
    [self drainBGTaskList:NO];
}

-(void)endAllBackgroundTasks
{
    [self drainBGTaskList:YES];
}

-(void)drainBGTaskList:(BOOL)all
{
    //mark end of each of our background task
    UIApplication* application = [UIApplication sharedApplication];
    if([application respondsToSelector:@selector(endBackgroundTask:)]){
        NSUInteger count=self.bgTaskIdList.count;
        for ( NSUInteger i=(all?0:1); i<count; i++ )
        {
            UIBackgroundTaskIdentifier bgTaskId = [[self.bgTaskIdList objectAtIndex:0] integerValue];
            NSLog(@"正在结束后台任务 id -%lu", (unsigned long)bgTaskId);
            [application endBackgroundTask:bgTaskId];
            [self.bgTaskIdList removeObjectAtIndex:0];
        }
        if ( self.bgTaskIdList.count > 0 )
        {
            NSLog(@"持续后台任务 id %@", [self.bgTaskIdList objectAtIndex:0]);
        }
        if ( all )
        {
            NSLog(@"没有更多的后台任务");
            [application endBackgroundTask:self.masterTaskId];
            self.masterTaskId = UIBackgroundTaskInvalid;
        }
        else
        {
            NSLog(@"保持主后台任务 id %lu", (unsigned long)self.masterTaskId);
        }
    }
}
@end
