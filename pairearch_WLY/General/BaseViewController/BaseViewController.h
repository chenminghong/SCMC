//
//  BaseViewController.h
//  pairearch_WLY
//
//  Created by Leo on 2017/3/27.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NestedSelectModel;

typedef void(^ProcessEndBlock)(NSDictionary *responseInfo);

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NestedSelectModel *selectedModel;

@property (nonatomic, copy) ProcessEndBlock processEndBlock;

@end
