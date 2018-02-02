//
//  BiddingInformationCellTwo.m
//  pairearch_WLY
//
//  Created by Jean on 2017/9/22.
//  Copyright © 2017年 Leo. All rights reserved.
//

#import "BiddingInformationCellTwo.h"

@implementation BiddingInformationCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //修改分割线的颜色（由于高度为0.5的分割线无法修改颜色，故把高度设为1然后alpha值设为0.4看到的UI效果相同）
    for (UIView *subView in self.contentView.subviews) {
        if (subView.tag >= 1000) {
            subView.backgroundColor = TABLE_SEPARATOR_COLOR;
            subView.alpha = 0.4;
            NSLog(@"wwww");
        }
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.y += 20;
    frame.size.height -= 20;
    [super setFrame:frame];
}

+ (instancetype)getListCellWithTable:(UITableView *)table indexPath:(NSIndexPath *)indexPath {
    BiddingInformationCellTwo *cell = [table dequeueReusableCellWithIdentifier:@"BiddingInformationCellTwo"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BiddingInformationCellTwo" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
