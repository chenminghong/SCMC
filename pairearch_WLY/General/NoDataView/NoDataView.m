//
//  NoDataView.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/29.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

+ (instancetype)getPlaceHoldViewWithImgName:(NSString *)imgName titleText:(NSString *)titleText {
    NoDataView *view = [[[NSBundle mainBundle] loadNibNamed:@"NoDataView" owner:self options:nil] firstObject];
    view.imgView.image = [UIImage imageNamed:imgName];
    view.textLabel.text = titleText;
    view.textLabel.textColor = UIColorFromRGB(0x666666);
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
