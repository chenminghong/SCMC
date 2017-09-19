//
//  CustomVerticalButton.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "CustomVerticalButton.h"

@implementation CustomVerticalButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat innerMargin = CGRectGetHeight(self.bounds) * 40.0 / 305;
    CGFloat imgWidth = CGRectGetWidth(self.bounds) / 3.0;
    CGRect newFrame = [self titleLabel].frame;
    CGFloat contentHeight = imgWidth + innerMargin + newFrame.size.height;
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.0, CGRectGetHeight(self.bounds) / 2.0);
    self.imageView.frame = CGRectMake(center.x - imgWidth / 2.0, center.y - contentHeight / 2.0, imgWidth, imgWidth);
    
    //Center text
    newFrame.origin.x = 0;
    newFrame.origin.y = CGRectGetMaxY(self.imageView.frame) + innerMargin;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
