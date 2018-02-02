//
//  PressEnterCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/12/8.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "PressEnterCell.h"

#import "NestedSelectModel.h"

@implementation PressEnterCell

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    PressEnterCell *cell = [table dequeueReusableCellWithIdentifier:@"PressEnterCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PressEnterCell" owner:self options:nil] firstObject];
    }
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 10;
    
    
    return cell;
}

- (void)setSelectedModel:(NestedSelectModel *)selectedModel {
    _selectedModel = selectedModel;
    if (selectedModel.processList.count <= 0) {
        return;
    }
    NSString *statusStr = selectedModel.processList[0];
    NSDictionary *paraDict = @{@"tuCode":self.selectedModel.tuCode,
                               @"process":statusStr,
                               @"driverTel":[LoginModel shareLoginModel].phone};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paraDict options:0 error:nil];
    NSString *paraStr = [jsonData base64EncodedStringWithOptions:0];
    UIImage *qrcodeImage = [QrcodeHelper createLogoQrcodeImageWithMessage:paraStr logoImage:[UIImage imageNamed:@"applogo"] imageSize:self.qrcodeImgView.bounds.size.width];
    self.qrcodeImgView.image = qrcodeImage;
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"装货码头%@", selectedModel.wharfName]];
    NSRange range = NSMakeRange(4, string.length - 4);
    [string setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:24.0]} range:range];
    self.wharfLabel.attributedText = string;
    
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
