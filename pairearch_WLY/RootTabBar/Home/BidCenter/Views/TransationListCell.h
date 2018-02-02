//
//  TransationListCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/9/21.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OfferButtonActionBlock)(NSIndexPath *indexPath);

@interface TransationListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *loadNumberLabel;          //发货单号
@property (weak, nonatomic) IBOutlet UILabel *latestLoadtimeLabel;     //最晚装运时间
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;               //起
@property (weak, nonatomic) IBOutlet UILabel *remainderTimeLabel;         //发货地名称
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UIButton *toButton;
@property (weak, nonatomic) IBOutlet UILabel *fromNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *toNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *toAddressLabel;
@property (weak, nonatomic) IBOutlet UIButton *immediatelyOfferBtn;

@property (nonatomic, strong) NSIndexPath *indexPath;                   //当前的cell位置;
@property (nonatomic, copy) OfferButtonActionBlock offerButtonAction;

//加载cell
+ (instancetype)getCellWithTable:(UITableView *)table  indexPath:(NSIndexPath *)indexPath offerButtonAction:(OfferButtonActionBlock)offerButtonAction;

@end
