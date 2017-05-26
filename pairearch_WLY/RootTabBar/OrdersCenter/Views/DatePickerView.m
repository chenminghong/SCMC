//
//  DatePickerView.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)getDatepickerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"DatePickerView" owner:self options:nil] firstObject];
}


+ (DatePickerView *)showInView:(UIView *)view frame:(CGRect)frame animationDuraton:(NSTimeInterval)duration {
    DatePickerView *dateView = [self getDatepickerView];
    dateView.frame = frame;
    [view addSubview:dateView];
    dateView.animationTimeInterval = duration;
    dateView.datePicker.minimumDate = [NSDate date];
    dateView.topLabel.backgroundColor = MAIN_THEME_COLOR;
    [dateView.selectTImeBtn setTitleColor:MAIN_THEME_COLOR forState:UIControlStateNormal];
    
    dateView.transform = CGAffineTransformMakeTranslation(0.0, frame.size.height);
    [UIView animateWithDuration:duration animations:^{
        dateView.transform = CGAffineTransformMakeTranslation(0.0, 0.0);
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:dateView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = dateView.layer.bounds;
    maskLayer.path = maskPath.CGPath;
    dateView.layer.mask = maskLayer;
    return dateView;
}

- (void)hide {
    CGRect frame = self.frame;
    [UIView animateWithDuration:self.animationTimeInterval animations:^{
        self.transform = CGAffineTransformMakeTranslation(0.0, frame.size.height);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
