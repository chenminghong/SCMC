//
//  NestedSelectModel.h
//  pairearch_WLY
//
//  Created by Jean on 2017/12/3.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface NestedSelectModel : BaseModel

@property (nonatomic, copy) NSString *tuCode;              //TU单号

@property (nonatomic, copy) NSString *statusCode;          //状态码

@property (nonatomic, copy) NSString *statusName;          //当前状态

@property (nonatomic, copy) NSString *orderCount;          //TU单中包含的订单数量

@property (nonatomic, strong) NSArray *processList;        //下一步的操作

@property (nonatomic, strong) NSDictionary *tuBase;        //base信息

@property (nonatomic, copy) NSString *frontLineUpCount;    //前面排队的车辆

@property (nonatomic, copy) NSString *intoFacotryTime;     //预计入厂时间

@property (nonatomic, copy) NSString *wharfName;           //装货码头

@end
