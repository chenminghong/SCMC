//
//  Mistake212Model.h
//  pairearch_WLY
//
//  Created by Jean on 2017/5/4.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface Mistake212Model : BaseModel

@property (nonatomic, copy) NSString *status;                   //订单状态

@property (nonatomic, copy) NSString *bidcount;                 //可抢订单数量

@property (nonatomic, copy) NSString *loadResult;               //请求结果是否有订单

@property (nonatomic, strong) NSMutableArray *orders;        //可接收订单数组

@property (nonatomic, copy) NSString *orderCode;                     //单号

@property (nonatomic, copy) NSString *wareDispatchTime;         //计划装运日期

@property (nonatomic, copy) NSString *sourceName;               //起始地名称

@property (nonatomic, copy) NSString *sourceAddr;               //起始地址

@property (nonatomic, copy) NSString *dcName;                   //收货地名称

@property (nonatomic, copy) NSString *dcAddress;                //收货地地址

@property (nonatomic, copy) NSString *planDate;                 //预约时间

@end
