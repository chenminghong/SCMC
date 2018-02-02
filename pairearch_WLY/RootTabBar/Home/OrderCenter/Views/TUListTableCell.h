//
//  TUListTableCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TuListModel;

@interface TUListTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tuNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *planTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *isGetTULabel;
@property (weak, nonatomic) IBOutlet UIImageView *nextMarkImgview;
@property (nonatomic, strong) TuListModel *tuModel;


/**
 获取当前的cell

 @param table 需要展示cell的table
 @param indexPath cell在table当前的位置
 @return 返回cell实例对象
 */
+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
