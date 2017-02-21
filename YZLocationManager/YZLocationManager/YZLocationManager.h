//
//  YZLocationManager.h
//  YZLocationManager
//
//  Created by 叶志强 on 2017/2/20.
//  Copyright © 2017年 CancerQ. All rights reserved.
//

/**
 * 推荐使用单例来创建该类
 *
 * 推荐使用单例来创建该类
 *
 * 推荐使用单例来创建该类
 *
 * 如果要使用后台定位的就必须使用单例创建方法 否则会被释放
 *
 * 在使用单例创建的时候要注意 使用block的时候是否被重新赋值，如果重新被赋值将使用最后一次赋值 例子：
 * YZLocationManager *manager = [YZLocationManager sharedLocationManager];
 *  [manager setYZLocationGeocderAddress:^(NSString *address, NSUInteger error) {   <--block1
 *       ..........
 *  }];
 *  [manager setYZLocationGeocderAddress:^(NSString *address, NSUInteger error) {   <--block2
 *       ..........
 *  }];
 * 最终将在block2才会回调
 * 使用 - (void)geoCodeSearchWithCoorinate:(CLLocationCoordinate2D)coordinate address:(void (^)(NSString *address, NSUInteger error))address 方法是也要注意 后面的block是和YZLocationGeocderAddress是使用的同一个block
 *
 * 推荐使用单例来创建该类
 *
 * 推荐使用单例来创建该类
 *
 * 推荐使用单例来创建该类
 *
 * 如果同一个页面多处要求同时定位，本类或许将不适用
*/

#import <Foundation/Foundation.h>

@import CoreLocation;
@interface YZLocationManager : NSObject

//是否开启后台定位 默认为NO
@property (nonatomic, assign) BOOL isBackGroundLocation;

//isBackGroudLocation为YES时，设置LocationInterval默认为1分钟
@property (nonatomic, assign) NSTimeInterval locationInterval;

//后台定位开启时 返回定位经纬度
@property (nonatomic, copy) void (^YZBackGroundLocationHander) (CLLocationCoordinate2D coordinate);

//后台定位开启时 返回反编码地理位置
@property (nonatomic, copy) void (^YZBackGroundGeocderAddressHander) (NSString *address);

//获取经纬度
@property (nonatomic, copy) void (^YZLocationCoordinate) (CLLocationCoordinate2D coordinate, NSError *error);

//获取反编码地理位置
@property (nonatomic, copy) void (^YZLocationGeocderAddress) (NSString *address, NSUInteger error);

//最近一次定位的经纬度
@property (nonatomic, readonly) CLLocationCoordinate2D lastCoordinate;

//最近一次反编码地理位置
@property (nonatomic, copy, readonly) NSString *lastGeocoderAddress;
//通过单例创建
+ (YZLocationManager *)sharedLocationManager;

//获取经纬度和反编码地理位置
- (void)receiveCoorinate:(void (^)(CLLocationCoordinate2D coordinate, NSError *error))coordinateHander geocderAddress:(void (^)(NSString *address, NSUInteger error))addressHander;

//传入经纬度获取反编码地理位置
- (void)geoCodeSearchWithCoorinate:(CLLocationCoordinate2D)coordinate address:(void (^)(NSString *address, NSUInteger error))address;

//开始定位
- (void)startLocationService;

//停止定位
- (void)stopLocationService;


@end
