//
//  LocationManager.m
//  pairearch_WLY
//
//  Created by Jean on 2017/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
/**
 初始化

 @return 返回当前定位上传助手对象
 */
+ (instancetype)shareManager {
    static LocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [LocationManager new];
        [sharedManager initLocationManager];
    });
    return sharedManager;
}


/**
 初始化定位助手对象
 */
- (void)initLocationManager {
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        /** 请求用户权限：分为：只在前台开启定位  /在后台也可定位， */
        /** 只在前台开启定位 */
        //        [self.locationManager requestWhenInUseAuthorization];
        /** 后台也可以定位 */
        [self.locationManager requestAlwaysAuthorization];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        /** iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。 */
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    }
    
    /** 开始定位 */
//    [self.locationManager startUpdatingLocation];
}


/**
 开始定位
 */
- (void)startUpdateLocation {
    [self.locationManager startUpdatingLocation];
}


/**
 结束定位
 */
- (void)stopUpdateLocation {
    [self.locationManager stopUpdatingLocation];
}

/**
 定位成功回调

 @param manager 定位助手对象
 @param locations 获取的位置信息
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"位置是：%@", locations);
}


/**
 定位错误回调

 @param manager 定位助手
 @param error 错误信息
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}





@end
