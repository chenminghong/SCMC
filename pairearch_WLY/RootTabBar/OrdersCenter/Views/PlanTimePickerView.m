//
//  PlanTimePickerView.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/17.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "PlanTimePickerView.h"

#define K_ANIMATION_TIMEINTERVAL 0.2
#define K_TIME_PICKERVIEW_HEIGHT  300.0

@implementation PlanTimePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.shadowView];
        self.tapHide = YES;
        [UIView animateWithDuration:K_ANIMATION_TIMEINTERVAL animations:^{
            self.shadowView.alpha = 0.5;
        }];
        
        self.datePicker = [DatePickerView showInView:self frame:CGRectMake(0.0, kScreenHeight - K_TIME_PICKERVIEW_HEIGHT, kScreenWidth, K_TIME_PICKERVIEW_HEIGHT) animationDuraton:K_ANIMATION_TIMEINTERVAL];
        [self.datePicker.datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.datePicker.selectTImeBtn addTarget:self action:@selector(selectTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        self.shadowView = [[UIView alloc] initWithFrame:self.bounds];
        self.shadowView.backgroundColor = [UIColor blackColor];
        self.shadowView.alpha = 0.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [self.shadowView addGestureRecognizer:tap];
    }
    return _shadowView;
}

- (TimePickerView *)timePickerView {
    if (!_timePickerView) {
        self.timePickerView = [TimePickerView getTimePickerView];
        self.timePickerView.frame = CGRectMake(0.0, kScreenHeight - K_TIME_PICKERVIEW_HEIGHT, kScreenWidth, K_TIME_PICKERVIEW_HEIGHT);
//        self.timePickerView.timePickerView.showsSelectionIndicator = YES;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.frame = self.layer.bounds;
        maskLayer.path = maskPath.CGPath;
        self.timePickerView.layer.mask = maskLayer;
        [self.timePickerView.cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.timePickerView.sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timePickerView;
}


/**
 显示视图
 */
+ (PlanTimePickerView *)showTimeSelectView {
    PlanTimePickerView *pickerView = [[PlanTimePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:pickerView];
    return pickerView;
}


/**
 隐藏视图
 */
- (void)hide {
    [self.datePicker hide];
    [self.timePickerView hide];
    [UIView animateWithDuration:K_ANIMATION_TIMEINTERVAL animations:^{
        self.shadowView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setTapHide:(BOOL)tapHide {
    _tapHide = tapHide;
    if (tapHide) {
        self.shadowView.userInteractionEnabled = YES;
    } else {
        self.shadowView.userInteractionEnabled = NO;
    }
}

#pragma mark -- Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"测试数据";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    //    if (self.pickBlock) {
    //        self.pickBlock(self.dataList[row]);
    //        [self hidePickerView];
    //    }
}




#pragma mark -- 按钮点击事件

/**
 选择时间按钮点击事件
 */
- (void)selectTimeButtonAction:(UIButton *)sender {
    [UIView transitionFromView:self.datePicker toView:self.timePickerView duration:K_ANIMATION_TIMEINTERVAL options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        self.timePickerView.animationTimeInterval = K_ANIMATION_TIMEINTERVAL;
    }];
}


/**
 取消按钮点击事件
 */
- (void)cancelButtonAction:(UIButton *)sender {
    [UIView transitionFromView:self.timePickerView toView:self.datePicker duration:K_ANIMATION_TIMEINTERVAL options:UIViewAnimationOptionTransitionCrossDissolve completion:^(BOOL finished) {
        if (finished) {
            self.timePickerView.animationTimeInterval = K_ANIMATION_TIMEINTERVAL;
        }
    }];
}


/**
 确定按钮点击事件
 */
- (void)sureButtonAction:(UIButton *)sender {
    [self hide];
}


/**
 背景遮罩手势
 */
- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    [self hide];
}

- (void)datePickerValueChanged:(UIDatePicker *)sender {
    NSLog(@"%@", sender.date);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
