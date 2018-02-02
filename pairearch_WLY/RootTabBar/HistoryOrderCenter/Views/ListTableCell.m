//
//  ListTableCell.m
//  pairearch_WLY
//
//  Created by Leo on 2017/2/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "ListTableCell.h"

#import "OrderListModel.h"

@implementation ListTableCell

//加载cell
+ (instancetype)getCellWithTable:(UITableView *)table  indexPath:(NSIndexPath *)indexPath {
    ListTableCell *cell = [table dequeueReusableCellWithIdentifier:@"ListTableCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ListTableCell" owner:self options:nil] firstObject];
    }
    return cell;
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 20;
    frame.size.height -= 20;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.drawsAsynchronously = YES;
    self.loadNumberLabel.textColor = UIColorFromRGB(0x666666);
    self.resultLabel.textColor = UIColorFromRGB(0xc0022e);
    self.latestLoadtimeLabel.textColor = UIColorFromRGB(0x666666);
    self.weightLabel.textColor = UIColorFromRGB(0x666666);
    self.totalPriceLabel.textColor = UIColorFromRGB(0x666666);
    self.fromNameLabel.textColor = UIColorFromRGB(0x4d4d4d);
    self.fromAddressLabel.textColor = UIColorFromRGB(0x808080);
    self.toNameLabel.textColor = UIColorFromRGB(0x4d4d4d);
    self.toAddressLabel.textColor = UIColorFromRGB(0x808080);
    [self.fromButton setBackgroundImage:[UIImage imageNamed:@"zhuanghuo"] forState:UIControlStateNormal];
    [self.toButton setBackgroundImage:[UIImage imageNamed:@"xiehuo"] forState:UIControlStateNormal];
    
    self.typeStr = @"抢 单";
}

- (void)setOrderModel:(OrderListModel *)orderModel {
    _orderModel = orderModel;
}


//计算文字宽度
- (CGFloat)widthForTextString:(NSString *)tStr height:(CGFloat)tHeight fontSize:(CGFloat)tSize{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:tSize]};
    CGRect rect = [tStr boundingRectWithSize:CGSizeMake(MAXFLOAT, tHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width+5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect backgroundRect = CGRectMake(0, -30, 100, 25);
    
    CGFloat translateX = kScreenWidth - (CGRectGetWidth(backgroundRect) / sqrt(2.0));
    CGAffineTransform tranlate = CGAffineTransformMakeTranslation(translateX, 0.0);
    CGAffineTransform transform = CGAffineTransformRotate(tranlate, M_PI_4);
    CGContextConcatCTM(context, transform);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, backgroundRect);
    CGContextAddPath(context, path);
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0x00a7eb).CGColor);
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0x00a7eb).CGColor);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    
    UIFont *strFont = [UIFont systemFontOfSize:16.0];
    CGFloat strWidth = [self.typeStr boundingRectWithSize:CGSizeMake(MAXFLOAT, strFont.lineHeight) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:strFont, NSForegroundColorAttributeName:[UIColor whiteColor]} context:nil].size.width;
    CGRect strRect = CGRectMake(CGRectGetMidX(backgroundRect) - strWidth / 2.0, CGRectGetMaxY(backgroundRect)- strFont.lineHeight, strWidth, strFont.lineHeight);
    [self.typeStr drawInRect:strRect withAttributes:@{NSFontAttributeName:strFont, NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
