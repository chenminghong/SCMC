//
//  WaitEnterCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "WaitEnterCell.h"

#import "NestedSelectModel.h"

@implementation WaitEnterCell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    WaitEnterCell *cell = [table dequeueReusableCellWithIdentifier:@"WaitEnterCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WaitEnterCell" owner:self options:nil] firstObject];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    return cell;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    _selectedModel = selectedModel;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您前面还有%ld辆车", [selectedModel.frontLineUpCount integerValue]]];
    NSRange range = NSMakeRange(5, string.length - 7);
    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:26.0]} range:range];
    self.carCountLabel.attributedText = string;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH:mm"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *distanceDate = [NSDate dateWithTimeIntervalSince1970:[self.selectedModel.intoFacotryTime doubleValue] / 1000];
    NSString *timeString = [formatter stringFromDate:distanceDate];
    self.planEnterTimeLabel.text = timeString;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGFloat cornerRadius = 5.0;
    self.labelView.layer.masksToBounds = YES;
    self.labelView.layer.cornerRadius = cornerRadius;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.enterDesLabel.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.enterDesLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    self.enterDesLabel.layer.mask = maskLayer;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
