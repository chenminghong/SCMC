//
//  CustomHexagonLabel.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "CustomHexagonLabel.h"

@implementation CustomHexagonLabel

- (void)layoutSubviews {
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    [maskPath moveToPoint:CGPointMake(height/2.0, 0)];
    [maskPath addLineToPoint:CGPointMake(width-height/2.0, 0.0)];
    [maskPath addLineToPoint:CGPointMake(width, height/2.0)];
    [maskPath addLineToPoint:CGPointMake(width-height/2.0, height)];
    [maskPath addLineToPoint:CGPointMake(height/2.0, height)];
    [maskPath addLineToPoint:CGPointMake(0.0, height/2.0)];
    [maskPath closePath];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.layer.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


/**
 修改文字的渲染区域

 @param rect 文字的原始渲染区域
 */
- (void)drawTextInRect:(CGRect)rect {
    CGRect textRect = CGRectMake(CGRectGetHeight(self.bounds) / 2.0, rect.origin.y, rect.size.width - CGRectGetHeight(self.bounds), rect.size.height);
    [super drawTextInRect:textRect];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
