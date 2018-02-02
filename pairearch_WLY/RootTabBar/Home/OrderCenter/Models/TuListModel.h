//
//  TuListModel.h
//  pairearch_WLY
//
//  Created by Jean on 2017/11/24.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BaseModel.h"

@interface TuListModel : BaseModel

/*
 tuCode：TU编码
 planLoadDate：计划装运日期
 orderCount：运单数量
 */

@property (nonatomic, copy) NSString *tuCode;

@property (nonatomic, copy) NSString *planLoadDate;

@property (nonatomic, copy) NSString *orderCount;

@end
