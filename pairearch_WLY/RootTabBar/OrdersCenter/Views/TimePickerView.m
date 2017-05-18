//
//  TimePickerView.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topLabel.backgroundColor = MAIN_THEME_COLOR;
    [self.cancelButton setTitleColor:MAIN_THEME_COLOR forState:UIControlStateNormal];
    [self.sureButton setTitleColor:MAIN_THEME_COLOR forState:UIControlStateNormal];
}

+ (instancetype)getTimePickerView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TimePickerView" owner:self options:nil] firstObject];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"测试数据";
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
