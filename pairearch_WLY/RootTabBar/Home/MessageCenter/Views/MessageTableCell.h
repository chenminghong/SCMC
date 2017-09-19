//
//  MessageTableCell.h
//  pairearch_WLY
//
//  Created by Jean on 2017/9/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *kindTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

/**
 获取当前的cell
 
 @param table 需要展示cell的table
 @param indexPath cell在table当前的位置
 @return 返回cell实例对象
 */
+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath;

@end
