//
//  OrderListController.h
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListController : UIViewController

@property (nonatomic, copy) NSString *tuCode;


/**
 根据TU单查询当前的TU单订单详情数据

 @param target 当前依赖的控制器
 @param tuCode 需要查询的TU号
 @return 返回创建的当前浏览详情的控制器对象
 */
+ (instancetype)enterTulistDetailViewControllerWithTarget:(UIViewController *)target tuCode:(NSString *)tuCode status:(NSInteger)status;

@end
