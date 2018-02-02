//
//  OrderListModel.h
//  pairearch_WLY
//
//  Created by Jean on 2017/11/24.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface OrdersListModel : BaseModel

@property (nonatomic, copy) NSString *orderCode;        //装运单号
@property (nonatomic, copy) NSString *planLoadDate;     //计划装运日期
@property (nonatomic, copy) NSString *sourceName;       //发货工厂名称
@property (nonatomic, copy) NSString *sourceAddr;       //发货工厂地址
@property (nonatomic, copy) NSString *dcName;           //收货工厂名称
@property (nonatomic, copy) NSString *dcAddr;           //收货工厂地址
@property (nonatomic, copy) NSString *appoinStartTime;  //预约开始时间
@property (nonatomic, copy) NSString *appointEndTime;   //预约结束时间

@end
