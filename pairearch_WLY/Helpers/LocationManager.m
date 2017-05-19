//
//  LocationManager.m
//  pairearch_WLY
//
//  Created by Jean on 2017/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "LocationManager.h"

#define UPLOAD_TIMEINTERVAL   30

#define LATITUDE        @"latitude"  //纬度
#define LONGITUDE       @"longitude" //经度

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
        /** 后台定位 */
        [self.locationManager requestAlwaysAuthorization];
    }
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        /** iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。 */
        [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    }
    
    geocoder = [CLGeocoder new];
}


//初始化定时器
- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:UPLOAD_TIMEINTERVAL target:self selector:@selector(uploadLocationToServer) userInfo:nil repeats:YES];
    }
    return _timer;
}


//获取位置信息
- (void)setLocation:(CLLocation *)location {
    _location = location;
    [self getAddressInfoByLocation:location];
}

- (void)setOrderCode:(NSString *)orderCode {
    _orderCode = orderCode;
    if (orderCode.length > 0) {
        [self startUploadLocation];
    } else {
        [self stopUploadLocation];
    }
}


/**
 上传位置信息到后台
 */
- (void)uploadLocationToServer {
    if (self.orderCode.length <= 0) {
        return;
    }
    NSMutableDictionary *paraDict = [NSMutableDictionary dictionaryWithDictionary:self.addressInfo];
    [paraDict setObject:self.orderCode forKey:@"orderCode"];
    [paraDict setObject:[LoginModel shareLoginModel].tel.length>0? [LoginModel shareLoginModel].tel:@"" forKey:@"driverTel"];
    [[NetworkHelper shareClient] POST:UPLOAD_LOCATION_API parameters:paraDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *responseStr = [NSString stringWithFormat:@"%@", [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]];
        NSLog(@"成功：%@", responseStr);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.userInfo[ERROR_MSG]);
    }];
}


/**
 重启定时器
 */
- (void)startTimer {
    [self.timer setFireDate:[NSDate distantPast]];
}


/**
 暂停定时器
 */
- (void)stopTimer {
    [self.timer setFireDate:[NSDate distantFuture]];
}


/**
 开始定位上传
 */
- (void)startUploadLocation {
    [self startTimer];
    [self.locationManager startUpdatingLocation];
}


/**
 结束定位上传
 */
- (void)stopUploadLocation {
    [self stopTimer];
    [self.locationManager stopUpdatingLocation];
}


/**
 反地理编码

 @param location 地理位置对象
 */
-(void)getAddressInfoByLocation:(CLLocation *)location {
    __weak typeof(self) weakSelf = self;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (!error) {
            CLPlacemark *placemark=[placemarks firstObject];
            NSDictionary *locationDict = placemark.addressDictionary;
            NSLog(@"详细信息:%@", locationDict);
            
            CGFloat latitude = location.coordinate.latitude;
            CGFloat longitude = location.coordinate.longitude;
            NSDictionary *tempDict = [self locationMarsFromEarth_earthLat:latitude earthLon:longitude];  //地球坐标系转火星坐标系
            tempDict = [self baiduLocationFromMars_marsLat:[tempDict[LATITUDE] floatValue] marsLon:[tempDict[LONGITUDE] floatValue]]; //火星坐标转百度坐标系
            NSString *speed = [NSString stringWithFormat:@"%f", location.speed];
            NSString *direction = [NSString stringWithFormat:@"%f", location.course];
            NSArray *addressArr = [NSArray arrayWithArray:locationDict[@"FormattedAddressLines"]];
            NSString *address = addressArr.count? addressArr[0]:@"";
            NSString *province = locationDict[@"State"];
            NSString *city = locationDict[@"City"];
            NSString *area = locationDict[@"SubLocality"];
            NSString *remark = @"iOS";
            NSString *active = @"Y";
            
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *locationTime = [dateFormatter stringFromDate:location.timestamp];
            weakSelf.addressInfo = @{@"orderCode":@"",
                                 @"driverTel":@"",
                                 @"longitude":[NSString stringWithFormat:@"%@", tempDict[LONGITUDE]],
                                 @"latiude":[NSString stringWithFormat:@"%@", tempDict[LATITUDE]],
                                 @"speed":speed,
                                 @"direction":direction,
                                 @"address":address,
                                 @"province":province,
                                 @"city":city,
                                 @"area":area,
                                 @"remark":remark,
                                 @"active":active,
                                 @"locationTime":locationTime};
        }
    }];
}


#pragma mark -- CLLocationManagerDelegate

/**
 地理位置更新回调

 @param manager 定位助手
 @param newLocation 新位置
 @param oldLocation 旧的位置
 */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    NSDate *newLocDate = newLocation.timestamp;
    NSTimeInterval interval = [newLocDate timeIntervalSinceNow];
    if(fabs(interval) < 10 ) {
        self.location = newLocation;
        NSLog(@"位置更新了");
    }
}


/**
 定位错误回调

 @param manager 定位助手
 @param error 错误信息
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

//将UTC/GTM时间转换为当前系统标准时间
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate *destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}


#pragma mark -- 地理位置坐标转换

/**地球坐标 ---> 火星坐标*/
- (NSDictionary *)locationMarsFromEarth_earthLat:(double)latitude earthLon:(double)longitude {
    // 首先判断坐标是否属于天朝
    if (![self isInChinaWithlat:latitude lon:longitude]) {
        return @{LATITUDE:@(latitude),
                 LONGITUDE:@(longitude)
                 };
    }
    double a = 6378245.0;
    double ee = 0.00669342162296594323;
    
    double dLat = [self transform_earth_from_mars_lat_lat:(latitude - 35.0) lon:(longitude - 35.0)];
    double dLon = [self transform_earth_from_mars_lng_lat:(latitude - 35.0) lon:(longitude - 35.0)];
    double radLat = latitude / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    
    double newLatitude = latitude + dLat;
    double newLongitude = longitude + dLon;
    NSDictionary *dict = @{LATITUDE:@(newLatitude),
                          LONGITUDE:@(newLongitude)
                          };
    return dict;
}

- (BOOL)isInChinaWithlat:(double)lat lon:(double)lon {
    if (lon < 72.004 || lon > 137.8347)
        return NO;
    if (lat < 0.8293 || lat > 55.8271)
        return NO;
    return YES;
}

- (double)transform_earth_from_mars_lat_lat:(double)y lon:(double)x {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 3320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

- (double)transform_earth_from_mars_lng_lat:(double)y lon:(double)x {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}


#pragma mark -- 火星坐标 <---> 百度坐标

/** 百度坐标 => 火星坐标 */
- (NSDictionary *)marsLocationFromBaidu_baiduLat:(double)latitude baiduLon:(double)longitude {
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = longitude - 0.0065, y = latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double newLatitude = z * sin(theta);
    double newLongitude = z * cos(theta);
    NSDictionary *dict = @{LATITUDE:@(newLatitude),
                          LONGITUDE:@(newLongitude)
                          };
    return dict;
}


/** 火星坐标 => 百度坐标 */
- (NSDictionary *)baiduLocationFromMars_marsLat:(double)latitude marsLon:(double)longitude {
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = longitude, y = latitude;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    double newLatitude = z * sin(theta) + 0.006;
    double newLongitude = z * cos(theta) + 0.0065;
    NSDictionary *dict = @{LATITUDE:@(newLatitude),
                          LONGITUDE:@(newLongitude)
                          };
    return dict;
}




@end
