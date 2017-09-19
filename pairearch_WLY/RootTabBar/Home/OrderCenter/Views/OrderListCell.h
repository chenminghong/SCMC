//
//  OrderListCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *planLoadTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UILabel *fromNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *toButton;
@property (weak, nonatomic) IBOutlet UILabel *toNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAddressLabel;
@property (weak, nonatomic) IBOutlet UIView *separatorLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorLineHeight;

/**
 获取当前的cell
 
 @param table 需要展示cell的table
 @param indexPath cell在table当前的位置
 @return 返回cell实例对象
 */
+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
