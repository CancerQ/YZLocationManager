//
//  YZBackgroundTaskManager.h
//  YZLocationManager
//
//  Created by 叶志强 on 2017/2/20.
//  Copyright © 2017年 CancerQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@interface YZBackgroundTaskManager : NSObject
+ (instancetype)sharedBackgroundTaskManager;

- (UIBackgroundTaskIdentifier)beginNewBackgroundTask;
- (void)endAllBackgroundTasks;
@end
