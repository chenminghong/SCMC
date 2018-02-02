//
//  MyBMKLocationManager.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <BMKLocationkit/BMKLocationComponent.h>
#import <BMKLocationKit/BMKLocationAuth.h>

@interface MyBMKLocationManager : NSObject<BMKLocationManagerDelegate, BMKLocationAuthDelegate>

@property (nonatomic, strong) NSTimer *timer;   //定时器

@property (nonatomic, copy) NSString *tuCode;   //TU单号

@property (nonatomic, strong) BMKLocationManager *locationManager;

@property (nonatomic, strong) BMKLocation *location;

@property (nonatomic, copy) NSString *locationDes;   //位置描述

/**
 初始化
 
 @return 返回当前定位上传助手对象
 */
+ (instancetype)shareManager;


/**
 开始定位上传

 @param tuCode 需要绑定的tuCode
 */
+ (void)startUploadLocationWithTUCode:(NSString *)tuCode;

/**
 结束定位上传
 */
+ (void)stopUploadLocation;

@end
