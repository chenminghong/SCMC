//
//  OrderListTableFooter.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderListTableFooter.h"

@implementation OrderListTableFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.getOrderButton.layer.masksToBounds = YES;
    self.getOrderButton.layer.cornerRadius = 5;
}

+ (instancetype)getFooterView {
    return [[[NSBundle mainBundle] loadNibNamed:@"OrderListTableFooter" owner:self options:nil] firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
