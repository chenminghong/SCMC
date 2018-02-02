//
//  MyBMKLocationManager.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "MyBMKLocationManager.h"

#define UPLOAD_TIMEINTERVAL   300    //拍照上传时间间隔

@implementation MyBMKLocationManager

/**
 初始化
 
 @return 返回当前定位上传助手对象
 */
+ (instancetype)shareManager {
    static MyBMKLocationManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [MyBMKLocationManager new];
        [sharedManager initLocationManager];
    });
    return sharedManager;
}

/**
 初始化定位助手对象
 */
- (void)initLocationManager {
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:BMK_LOCATION_MANAGER_AK authDelegate:self];
    
    //初始化实例
    self.locationManager = [[BMKLocationManager alloc] init];
    //设置delegate
    self.locationManager.delegate = self;
    //设置返回位置的坐标系类型
    self.locationManager.coordinateType = BMKLocationCoordinateTypeBMK09LL;
    //设置距离过滤参数
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    //设置预期精度参数
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.activityType = CLActivityTypeOther;
    //设置应用位置类型
    self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    //设置是否自动停止位置更新
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    //设置是否允许后台定位
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    //设置位置获取超时时间
    self.locationManager.locationTimeout = 3;
    //设置获取地址信息超时时间
    self.locationManager.reGeocodeTimeout = 3;
}

//初始化定时器
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:UPLOAD_TIMEINTERVAL target:self selector:@selector(uploadLocationToServer) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 重启定时器
 */
- (void)startTimer {
    if (!_timer) {
        [self.timer fire];
    }
//    [self.timer setFireDate:[NSDate distantPast]];
}


/**
 暂停定时器
 */
- (void)stopTimer {
    if (_timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
//    [self.timer setFireDate:[NSDate distantFuture]];
}

/**
 上传位置信息到后台
 */
- (void)uploadLocationToServer {
    BMKLocation *location = self.location;
    if (!location.location) {
        return;
    }
    CLLocationCoordinate2D coordinate = location.location.coordinate;
    NSString *lngStr = [NSString stringWithFormat:@"%f", coordinate.longitude];
    NSString *latStr = [NSString stringWithFormat:@"%f", coordinate.latitude];
    NSString *locationDes = [NSString stringWithFormat:@"%@|%@|%@|%@|%@", location.rgcData.country, location.rgcData.province, location.rgcData.city, location.rgcData.district, location.rgcData.street];
    
    NSDictionary *paraDict = @{@"tuCode":self.tuCode,
                               @"driverTel":[LoginModel shareLoginModel].phone,
                               @"lng":lngStr,
                               @"lat":latStr,
                               @"addr":locationDes.length>0? locationDes:@"",
                               OPERATION_KEY:LOCATION_UPLOAD_API
                               };
    [NetworkHelper POST:PAIREACH_NETWORK_URL parameters:paraDict progress:nil endResult:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"LOC_UPLOAD:%@", error.userInfo[ERROR_MSG]);
        } else {
            NSLog(@"paraDict:%@", paraDict);
        }
    }];
}

/**
 开始定位上传
 */
+ (void)startUploadLocationWithTUCode:(NSString *)tuCode {
    if (tuCode.length <= 0) {
        return;
    }
    
    [[MyBMKLocationManager shareManager] setTuCode:tuCode];
    [[MyBMKLocationManager shareManager] startTimer];
    [[MyBMKLocationManager shareManager].locationManager setLocatingWithReGeocode:YES];
    [[MyBMKLocationManager shareManager].locationManager startUpdatingLocation];
}


/**
 结束定位上传
 */
+ (void)stopUploadLocation {
    [[MyBMKLocationManager shareManager] stopTimer];
    [[MyBMKLocationManager shareManager].locationManager stopUpdatingLocation];
}


- (void)BMKLocationManager:(BMKLocationManager *)manager didUpdateLocation:(BMKLocation *)location orError:(NSError *)error {
    if (error) {
        NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
        return;
    }
    if (location) {//得到定位信息，添加annotation
        self.location = location;
        if (location.location) {
//            NSLog(@"LOC = %@", location.location);
        }
        if (location.rgcData) {
            self.locationDes = [location.rgcData description].length > 0? [location.rgcData description]:@"";
//            NSLog(@"rgc = %@",[location.rgcData description]);
        }
    }
}


@end
