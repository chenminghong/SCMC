//
//  LocationManager.h
//  pairearch_WLY
//
//  Created by Jean on 2017/4/14.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
//初始化
+ (instancetype)shareManager;

//初始化定位数据
- (void)initLocationManager;

//开始定位
- (void)startUpdateLocation;
//结束定位
- (void)stopUpdateLocation;

@end
