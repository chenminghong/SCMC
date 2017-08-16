//
//  OrderListCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderListCell.h"

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.orderNumberLabel.textColor = UIColorFromRGB(0x666666);
    self.planLoadTimeLabel.textColor = UIColorFromRGB(0x808080);
    self.appointTimeLabel.textColor = UIColorFromRGB(0x808080);
    self.fromNameLabel.textColor = UIColorFromRGB(0x666666);
    self.fromAddressLabel.textColor = UIColorFromRGB(0x666666);
    self.toNameLabel.textColor = UIColorFromRGB(0x666666);
    self.toAddressLabel.textColor = UIColorFromRGB(0x666666);
    self.separatorLine.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorLineHeight.constant = 0.5;
    [self.fromButton setBackgroundImage:[UIImage imageNamed:@"zhuanghuo"] forState:UIControlStateNormal];
    [self.toButton setBackgroundImage:[UIImage imageNamed:@"xiehuo"] forState:UIControlStateNormal];
}

/**
 获取当前的cell
 
 @param table 需要展示cell的table
 @param indexPath cell在table当前的位置
 @return 返回cell实例对象
 */
+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    OrderListCell *cell = [table dequeueReusableCellWithIdentifier:@"OrderListCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
