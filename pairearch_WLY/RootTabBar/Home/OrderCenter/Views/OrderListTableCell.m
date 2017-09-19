//
//  OrderListTableCell.m
//  pairearch_WLY
//
//  Created by Jean on 2017/8/16.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "OrderListTableCell.h"

@implementation OrderListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.tuNumberLabel.textColor = UIColorFromRGB(0x4c4c4c);
    self.orderCountLabel.textColor = UIColorFromRGB(0x4c4c4c);
    self.separatorLine.backgroundColor = TABLE_SEPARATOR_COLOR;
    self.separatorLineHeight.constant = 0.5;
}


+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    OrderListTableCell *cell = [table dequeueReusableCellWithIdentifier:@"OrderListTableCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"OrderListTableCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
