//
//  AppDelegate.m
//  YZLocationManager
//
//  Created by 叶志强 on 2017/2/20.
//  Copyright © 2017年 CancerQ. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "YZLocationManager.h"

@interface AppDelegate ()<BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"NdlH2Fb42HldFjZCE7LxOT3NGchyzmUG" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application{
    
}
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
