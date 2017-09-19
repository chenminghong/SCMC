//
//  MessageTableCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/18.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "MessageTableCell.h"

@implementation MessageTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.kindTypeLabel.layer.masksToBounds = YES;
    self.kindTypeLabel.layer.cornerRadius = 5.0;
}

/**
 获取当前的cell
 
 @param table 需要展示cell的table
 @param indexPath cell在table当前的位置
 @return 返回cell实例对象
 */
+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    MessageTableCell *cell = [table dequeueReusableCellWithIdentifier:@"MessageTableCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MessageTableCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
