//
//  PlanTimePickerView.h
//  pairearch_WLY
//
//  Created by Jean on 2017/5/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TimePickerView.h"
#import "DatePickerView.h"

@interface PlanTimePickerView : UIView

@property (nonatomic, strong) UIView *shadowView;  //背景遮盖

@property (nonatomic, strong) DatePickerView *datePicker;  //时间选择器

@property (nonatomic, strong) TimePickerView *timePickerView; //时间段选择


/**
 显示时间选择器

 @return 显示的时间选择器对象
 */
+ (PlanTimePickerView *)showTimeSelectView;

@end
