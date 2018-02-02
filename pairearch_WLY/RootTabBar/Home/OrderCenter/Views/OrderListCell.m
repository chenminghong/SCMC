//
//  OrderListCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderListCell.h"

#import "OrdersListModel.h"

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.orderNumberLabel.textColor = UIColorFromRGB(0x666666);
    self.planLoadTimeLabel.textColor = UIColorFromRGB(0x808080);
    self.fromNameLabel.textColor = UIColorFromRGB(0x666666);
    self.fromAddressLabel.textColor = UIColorFromRGB(0x666666);
    self.toNameLabel.textColor = UIColorFromRGB(0x666666);
    self.toAddressLabel.textColor = UIColorFromRGB(0x666666);
    self.separatorLine.backgroundColor = TABLE_SEPARATOR_COLOR;
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

- (void)setOrderListModel:(OrdersListModel *)orderListModel {
    _orderListModel = orderListModel;
    self.orderNumberLabel.text = [NSString stringWithFormat:@"单号：%@", orderListModel.orderCode];
    
    self.fromNameLabel.text = orderListModel.sourceName;
    self.fromAddressLabel.text = orderListModel.sourceAddr;
    self.toNameLabel.text = orderListModel.dcName;
    self.toAddressLabel.text = orderListModel.dcAddr;
    
    if (orderListModel.appoinStartTime.length <= 0 || orderListModel.appointEndTime.length <= 0) {
        self.planLoadTimeLabel.hidden = YES;
        self.topConstrant.constant = 0.0;
        self.heightConstrant.constant = 0.0;
    } else {
        self.planLoadTimeLabel.hidden = NO;
        self.topConstrant.constant = 10.0;
        self.heightConstrant.constant = 16.0;
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"YYYY-MM-DD HH:mm"];
        [formatter setTimeZone:[NSTimeZone systemTimeZone]];
        NSDate *distanceDateStart = [NSDate dateWithTimeIntervalSince1970:[orderListModel.appoinStartTime doubleValue] / 1000];
        NSString *startTimeString = [formatter stringFromDate:distanceDateStart];
        [formatter setDateFormat:@"HH:mm"];
        NSDate *distanceDateEnd = [NSDate dateWithTimeIntervalSince1970:[orderListModel.appointEndTime doubleValue] / 1000];
        NSString *endTimeString = [formatter stringFromDate:distanceDateEnd];
        self.planLoadTimeLabel.text = [NSString stringWithFormat:@"预计发货日期：%@-%@", startTimeString, endTimeString];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
