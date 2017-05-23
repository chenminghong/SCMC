//
//  BiddingFooterView.m
//  pairearch_WLY
//
//  Created by Jean on 2017/5/23.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BiddingFooterView.h"

@implementation BiddingFooterView



+ (instancetype)getFooterView {
    return [[[NSBundle mainBundle] loadNibNamed:@"BiddingFooterView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.biddingTf.keyboardType = UIKeyboardTypeDecimalPad;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
