//
//  HomePageModel.h
//  pairearch_WLY
//
//  Created by Leo on 2017/3/10.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface HomePageModel : BaseModel

@property (nonatomic, copy) NSString *orderGradCount;                         //可抢单数量

@property (nonatomic, copy) NSString *orderGradingCount;                      //抢单中数量

@property (nonatomic, copy) NSString *orderWaitTransCount;                    //待运送数量

@property (nonatomic, copy) NSString *orderWaitTransingCount;                 //运送中数量

@property (nonatomic, copy) NSString *tuCode;                                 //TU单号

@end
