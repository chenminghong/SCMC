//
//  ListTableCell.h
//  pairearch_WLY
//
//  Created by Leo on 2017/2/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderListModel;

@interface ListTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *loadNumberLabel;          //发货单号
@property (weak, nonatomic) IBOutlet UILabel *latestLoadtimeLabel;     //最晚装运时间
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;              //抢
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;               //起
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;         //发货地名称
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UIButton *toButton;
@property (weak, nonatomic) IBOutlet UILabel *fromNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *toNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAddressLabel;
@property (copy, nonatomic) NSString *typeStr;

@property (nonatomic, strong) NSIndexPath *indexPath;                   //当前的cell位置;

@property (nonatomic, strong) OrderListModel *orderModel;               //数据模型

//加载cell
+ (instancetype)getCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
