//
//  NestedSelectStateController.h
//  pairearch_WLY
//
//  Created by Leo on 2017/3/6.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomePageModel;

@interface NestedSelectStateController : UIViewController

@property (nonatomic, copy) NSString *code;            //订单编号

@property (nonatomic, assign) NSInteger status;        //订单状态码

@property (nonatomic, strong) HomePageModel *homePageModel;

@end
